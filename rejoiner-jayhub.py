import os
import time
import json
import urllib.request
import urllib.error
from datetime import datetime, timezone

# Prefix used to find Roblox and any clone/mod packages installed on the device
# e.g. com.roblox.client, com.roblox.cliena, com.roblox.clienu, etc.
app_package_prefix = "com.roblox"

# Private server link will be asked from the user at runtime (see get_private_server_url())
url = None

# API to poll for current weather
weather_api = "https://api.gag2.gg/api/live/weather"

# Weather types that should trigger opening the private server
TARGET_WEATHERS = {"goldmoon", "rainbow_moon"}

# How often to poll the API (seconds)
poll_interval = 1

# Delay after force-stop before doing anything else (seconds)
DELAY_AFTER_STOP = 6

# Track whether the app is currently "open" (so we don't spam force-stop/launch every second)
app_is_open = False


def parse_iso(ts):
    """Parse an ISO8601 timestamp like '2026-07-08T06:18:00.000Z' into an aware datetime."""
    if not ts:
        return None
    try:
        # Replace trailing Z with +00:00 so fromisoformat can handle it
        return datetime.fromisoformat(ts.replace("Z", "+00:00"))
    except ValueError:
        return None


def fetch_weather():
    """
    Fetch the current weather block.
    Returns (weather_type, weather_name, starts_at, ends_at) or (None, None, None, None) on failure.
    """
    try:
        req = urllib.request.Request(
            weather_api,
            headers={"User-Agent": "Mozilla/5.0"}
        )
        with urllib.request.urlopen(req, timeout=5) as resp:
            data = json.loads(resp.read().decode("utf-8"))
            current = data.get("weather", {}).get("current", {})
            weather_type = current.get("type")
            weather_name = current.get("name")
            starts_at = parse_iso(current.get("startsAt"))
            ends_at = parse_iso(current.get("endsAt"))
            return weather_type, weather_name, starts_at, ends_at
    except (urllib.error.URLError, urllib.error.HTTPError, ValueError, TimeoutError) as e:
        print("Error fetching weather: {}".format(e))
        return None, None, None, None


def is_within_window(starts_at, ends_at):
    """
    Check whether 'now' actually falls within [startsAt, endsAt].
    This guards against the API reporting a stale/expired weather event.
    """
    if starts_at is None or ends_at is None:
        # If we can't parse the window, fall back to trusting the API's type field
        return True
    now = datetime.now(timezone.utc)
    return starts_at <= now <= ends_at


def get_roblox_packages():
    """
    Query the device for every installed package starting with app_package_prefix
    (catches the real client plus any clone/mod packages like com.roblox.cliena, etc.)
    Returns a list of package name strings.
    """
    try:
        cmd = "su -c 'pm list packages {}'".format(app_package_prefix)
        result = os.popen(cmd).read()
        packages = []
        for line in result.splitlines():
            line = line.strip()
            if line.startswith("package:"):
                pkg_name = line.replace("package:", "").strip()
                if pkg_name.startswith(app_package_prefix):
                    packages.append(pkg_name)
        return packages
    except Exception as e:
        print("Error discovering Roblox packages: {}".format(e))
        return []


def get_private_server_url():
    """
    Ask the user to paste their private server share link at runtime.
    Keeps asking until something that looks like a valid roblox.com link is entered.
    """
    while True:
        entered = input("Paste your Roblox private server link: ").strip()
        if entered.startswith("https://www.roblox.com/") or entered.startswith("https://roblox.com/"):
            return entered
        print("That doesn't look like a valid roblox.com link. Please try again.")


def force_stop_roblox():
    packages = get_roblox_packages()
    if not packages:
        print("No com.roblox* packages found on device.")
        return
    for pkg in packages:
        print("Force-stopping {}...".format(pkg))
        os.system("su -c 'am force-stop {}'".format(pkg))
    time.sleep(DELAY_AFTER_STOP)


def launch_private_server():
    packages = get_roblox_packages()
    if not packages:
        print("No com.roblox* packages found on device. Falling back to default handler.")
        os.system("su -c 'am start -a android.intent.action.VIEW -d \"{}\"'".format(url))
        return
    for pkg in packages:
        print("Launching private server link on {}...".format(pkg))
        os.system(
            "su -c 'am start -a android.intent.action.VIEW -d \"{}\" -p {}'".format(url, pkg)
        )
        # Small stagger so each clone gets its own launch intent processed cleanly
        time.sleep(2)


def main():
    global app_is_open, url
    url = get_private_server_url()
    print("Starting weather watcher. Polling every {}s...".format(poll_interval))

    while True:
        weather_type, weather_name, starts_at, ends_at = fetch_weather()

        if weather_type is None:
            # Couldn't fetch, just wait and retry
            time.sleep(poll_interval)
            continue

        active_now = is_within_window(starts_at, ends_at)
        is_target = weather_type.lower() in TARGET_WEATHERS and active_now

        if not active_now and weather_type.lower() in TARGET_WEATHERS:
            # API still shows a target weather but its window has already ended (stale response)
            print("Stale data: {} window has ended (endsAt={}). Treating as inactive.".format(
                weather_name, ends_at))

        if is_target and not app_is_open:
            print("Target weather ACTIVE: {} ({}). Window: {} -> {}. Opening server.".format(
                weather_name, weather_type, starts_at, ends_at))
            launch_private_server()
            app_is_open = True

        elif not is_target and app_is_open:
            print("Weather is now: {} ({}) - not active/target. Closing app.".format(weather_name, weather_type))
            force_stop_roblox()
            app_is_open = False

        else:
            print("Weather: {} ({}), active_now={} - no action needed.".format(
                weather_name, weather_type, active_now))

        time.sleep(poll_interval)


if __name__ == "__main__":
    main()
