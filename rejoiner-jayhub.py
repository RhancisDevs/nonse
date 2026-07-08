import os
import time
import json
import urllib.request
import urllib.error
from datetime import datetime, timezone

app_package_prefix = "com.roblox"

url = None

weather_api = "https://api.gag2.gg/api/live/weather"

TARGET_WEATHERS = {"goldmoon", "rainbow_moon"}
poll_interval = 1

DELAY_AFTER_STOP = 6
app_is_open = False

def parse_iso(ts):
    if not ts:
        return None
    try:
        return datetime.fromisoformat(ts.replace("Z", "+00:00"))
    except ValueError:
        return None


def fetch_weather():
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
    if starts_at is None or ends_at is None:
        return True
    now = datetime.now(timezone.utc)
    return starts_at <= now <= ends_at


def get_roblox_packages():
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
        time.sleep(2)


def main():
    global app_is_open, url
    url = get_private_server_url()
    print("Starting weather rejoiner. Checking weather every {}s...".format(poll_interval))

    while True:
        weather_type, weather_name, starts_at, ends_at = fetch_weather()

        if weather_type is None:
            time.sleep(poll_interval)
            continue

        active_now = is_within_window(starts_at, ends_at)
        is_target = weather_type.lower() in TARGET_WEATHERS and active_now

        if not active_now and weather_type.lower() in TARGET_WEATHERS:
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
