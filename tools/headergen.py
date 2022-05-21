#!/usr/bin/env python3

#################################################
##                 headergen.py                ##
##   A tool for generating dotfiles' headers   ##
##                                             ##
##                    GGORG                    ##
##         https://gh.ggorg.tk/dotfiles        ##
##              tools/headergen.py             ##
#################################################

import argparse

AUTHOR = "GGORG"
REPO = "https://gh.ggorg.tk/dotfiles"


def gen_nice_header(destfile: str, file: str, desc: str):
    lines = [
        destfile,
        desc,
        "",
        AUTHOR,
        REPO,
        file
    ]

    maxline = max(len(line) for line in lines)
    linelen = maxline + 2*2

    new_lines = [line.center(linelen) for line in lines]

    out_lines = ["#"*(linelen+6)] + \
        [f"## {line} ##" for line in new_lines] + ["#"*(linelen+6)]

    return "\n".join(out_lines)


def gen_machine_header(destfile: str, file: str):
    return f"# @File {file}\n# @Copy {destfile}"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-f", "--file", required=True,
                        help="File to generate header for")
    parser.add_argument("-d", "--desc", required=True,
                        help="Description of the file")
    parser.add_argument("-c", "--copy", required=True, help="Destination file")
    parser.add_argument("-m", "--no-machine", action="store_true",
                        help="Don't generate machine header")
    parser.add_argument("-n", "--no-nice", action="store_true",
                        help="Don't generate nice header")
    args = parser.parse_args()

    if not args.no_machine:
        print(gen_machine_header(args.copy, args.file))

    if not (args.no_machine or args.no_nice):
        print()

    if not args.no_nice:
        print(gen_nice_header(args.copy, args.file, args.desc))


if __name__ == "__main__":
    main()
