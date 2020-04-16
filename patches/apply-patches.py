import json
import os
import shutil

PATCH_PATH = os.path.abspath(os.path.dirname(__file__))
OPENWRT_ROOT_PATH = os.path.dirname(PATCH_PATH)
CONFIG_PATH = os.path.join(PATCH_PATH, "config.json")

def main():
    with open(CONFIG_PATH) as cfg_fs:
        cfg = json.load(cfg_fs)

    print("Installing patches:")
    for k,v in cfg.items():
        print("{} -> {}".format(k,v))
        src = os.path.join(PATCH_PATH, k)
        dst = os.path.join(OPENWRT_ROOT_PATH, v, "patches")
        if not os.path.exists(dst):
            os.mkdir(dst)
        shutil.copy(src, dst)

if __name__ == "__main__":
    exit(main())
