#!/usr/bin/env python3
"""Resolve one immutable PHC/native core/UI chain for the installation fixtures."""
import argparse
import json
import os
from pathlib import Path
import re
import subprocess
import urllib.request

root = Path(__file__).resolve().parent.parent

def wrapper_version():
    requirements = {}
    for relative in [
        'ios/purchases_flutter.podspec',
        'macos/purchases_flutter.podspec',
        'purchases_ui_flutter/ios/purchases_ui_flutter.podspec',
        'purchases_ui_flutter/macos/purchases_ui_flutter.podspec',
    ]:
        contents = (root / relative).read_text()
        match = re.search(r'(?:s|spec)\.dependency\s+[\'\"]PurchasesHybridCommon(?:UI)?[\'\"],\s*[\'\"]([^\'\"]+)', contents)
        if not match:
            raise RuntimeError(f'Expected an exact PHC dependency in {relative}')
        requirements[relative] = match.group(1)
    if len(set(requirements.values())) != 1:
        raise RuntimeError(f'Apple core/UI PHC requirements must match: {requirements}')
    return next(iter(requirements.values()))

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--ref', default=os.environ.get('RC_PHC_REF'))
parser.add_argument('--output', default=str(root/'build/git-pods.json'))
args = parser.parse_args()
expected_version = wrapper_version()
# Releases resolve their matching tag; snapshot requirements resolve the major development branch.
if not args.ref:
    args.ref = '.'.join(expected_version.split('.')[:2]) + '-dev' if expected_version.endswith('-SNAPSHOT') else expected_version
repository = 'https://github.com/RevenueCat/purchases-hybrid-common.git'
if re.fullmatch(r'[0-9a-f]{40}', args.ref):
    commit = args.ref
else:
    refs = subprocess.check_output([
        'git', 'ls-remote', '--exit-code', repository,
        'refs/heads/' + args.ref, 'refs/tags/' + args.ref,
        'refs/tags/' + args.ref + '^{}'
    ], text=True).splitlines()
    commit = refs[-1].split()[0]
if not re.fullmatch(r'[0-9a-f]{40}', commit):
    raise RuntimeError('Could not resolve the PHC commit')

def podspec(name):
    url = f'https://raw.githubusercontent.com/RevenueCat/purchases-hybrid-common/{commit}/{name}.podspec'
    with urllib.request.urlopen(url, timeout=30) as response:
        return response.read().decode()

def value(pattern, text):
    match = re.search(pattern, text)
    if not match:
        raise RuntimeError('Expected an exact version in the PHC podspec')
    return match.group(1)

core = podspec('PurchasesHybridCommon')
ui = podspec('PurchasesHybridCommonUI')
version_pattern = r's\.version\s*=\s*[\'\"]([^\'\"]+)'
version = value(version_pattern, core)
if value(version_pattern, ui) != version:
    raise RuntimeError('PHC core and UI versions must match')
if version != expected_version:
    raise RuntimeError(f'PHC {args.ref} declares {version}, but the wrapper requires {expected_version}')
data = {
    'phc_commit': commit,
    'phc_version': version,
    'native_version': value(r's\.dependency\s+[\'\"]RevenueCat[\'\"],\s*[\'\"]([^\'\"]+)', core),
    'native_ui_version': value(r's\.dependency\s+[\'\"]RevenueCatUI[\'\"],\s*[\'\"]([^\'\"]+)', ui)
}
path = Path(args.output)
path.parent.mkdir(parents=True, exist_ok=True)
path.write_text(json.dumps(data, indent=2) + '\n')
print(f'PHC {version} at {commit}; native core/UI {data["native_version"]}/{data["native_ui_version"]}')
