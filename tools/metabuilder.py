#!/usr/bin/env python3

##################################################
##                metabuilder.py                ##
##   A tool for generating dotfiles' metadata   ##
##                                              ##
##                    GGORG                     ##
##         https://gh.ggorg.tk/dotfiles         ##
##             tools/metabuilder.py             ##
##################################################

import argparse
import json
import os


def scan_file(path: str):
    print(f"[*] Scanning {path}")

    with open(path, "r") as f:
        lines = f.readlines()

    depends = []
    pkgdepends = []

    for line in lines:
        line = line.strip()
        if not line.startswith("##"):
            continue
        line = line.lstrip("## ").strip()
        if line.startswith("@Requires"):
            dep = line.split()[1]
            print(f"[*] [{path}] Found pkg dependency {dep}")
            pkgdepends.append(dep)
        elif line.startswith("@Needs"):
            dep = line.split()[1]
            print(f"[*] [{path}] Found dependency {dep}")
            depends.append(dep)

    return depends, pkgdepends


def scan_depends(path: str, files: list):
    depends = []
    pkgdepends = []

    for file in files:
        d, p = scan_file(os.path.join(path, file))
        depends += d
        pkgdepends += p

    return list(sorted(set(depends))), list(sorted(set(pkgdepends)))


def find_files(path: str):
    return [file
            for file in os.listdir(path)
            if os.path.isfile(os.path.join(path, file))
            and file.lower() not in ["readme.md", "dotfiles.json", "setup.sh"]]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-n", "--name", required=True,
                        help="Name of the dotfiles")
    parser.add_argument("-p", "--path", required=True,
                        help="Directory to generate metadata for")
    parser.add_argument("-d", "--desc", required=True,
                        help="Description of the dotfiles")
    parser.add_argument("-f", "--files", nargs="+", required=False, default=[],
                        help="The files to include")
    parser.add_argument("-s", "--no-scan", action="store_true",
                        help="Don't scan for dependencies")
    args = parser.parse_args()

    files = args.files
    if files == []:
        files = find_files(args.path)

    data = {
        "name": args.name,
        "path": args.path,
        "description": args.desc,
        "depends": [],
        "pkgdepends": [],
        "files": files
    }

    if not args.no_scan:
        data["depends"], data["pkgdepends"] = scan_depends(args.path, files)

    with open(os.path.join(args.path, "dotfiles.json"), "w") as f:
        json.dump(data, f, indent=2)


if __name__ == "__main__":
    main()
