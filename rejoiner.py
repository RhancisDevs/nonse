import os
import time

url = "https://www.roblox.com/games/start?placeId=107778070777162"

result = os.popen("su -c 'pm list packages free.noka'").read()

packages = []

for line in result.splitlines():
    line = line.strip()
    if line.startswith("package:"):
        pkg = line.replace("package:", "").strip()
        if pkg.startswith("free.noka"):
            packages.append(pkg)

for pkg in packages:
    print("Opening URL on {}...".format(pkg))
    os.system(
        "su -c 'am start -a android.intent.action.VIEW -d \"{}\" -p {}'".format(url, pkg)
    )
    time.sleep(2)
