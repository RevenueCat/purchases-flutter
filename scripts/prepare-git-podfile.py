#!/usr/bin/env python3
"""Add the fixture's Git overrides once, or check that regeneration preserved them."""
import argparse
import json
import os
from pathlib import Path
import re

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('podfile', type=Path)
parser.add_argument('--check', action='store_true')
args = parser.parse_args()
root = Path(__file__).resolve().parent.parent
helper = os.path.relpath(root/'scripts/git-pods', args.podfile.resolve().parent)
require_line = 'require_relative ' + json.dumps(helper)
text = args.podfile.read_text()
calls = re.findall(r'^\s*revenuecat_git_pods\s*$', text, re.MULTILINE)
if args.check:
    if len(calls) != 1 or text.splitlines().count(require_line) != 1:
        raise RuntimeError('Regeneration must preserve the helper import and one RevenueCat Git override')
elif not calls:
    text = require_line + '\n\n' + text
    text, count = re.subn(r'^(target [\'\"][^\'\"]+[\'\"] do)[ \t]*$', r'\1\n  revenuecat_git_pods', text, count=1, flags=re.MULTILINE)
    if count != 1:
        raise RuntimeError('Expected an application target in the generated Podfile')
    args.podfile.write_text(text)
elif len(calls) != 1:
    raise RuntimeError('Expected exactly one RevenueCat Git override')
print('Verified Git overrides in', args.podfile)
