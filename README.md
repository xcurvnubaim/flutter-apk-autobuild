# Flutter APK Auto Release

Automatically builds and publishes a Flutter APK to GitHub Releases when a version tag is pushed.

---

## How It Works

```
Push tag (v1.0.0)
      │
      ▼
GitHub Actions triggered
      │
      ▼
┌─────────────────────────┐
│  1. Checkout code        │
│  2. Setup Java 17        │
│  3. Setup Flutter        │
│  4. flutter pub get      │
│  5. flutter build apk    │
│  6. Publish GitHub       │
│     Release + APK        │
└─────────────────────────┘
      │
      ▼
Release published at:
Repo → Releases → vX.X.X → app-release.apk
```

---

## Workflow File

Located at `.github/workflows/release.yml`

```yaml
name: Flutter APK Release

on:
  push:
    tags:
      - 'v*'

jobs:
  build:
    name: Build & Release APK
    runs-on: ubuntu-latest

    permissions:
      contents: write

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Set up Java
        uses: actions/setup-java@v4
        with:
          distribution: 'zulu'
          java-version: '17'

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: 'stable'

      - name: Install Dependencies
        run: flutter pub get

      - name: Build APK
        run: flutter build apk --release

      - name: Create GitHub Release
        uses: softprops/action-gh-release@v2
        with:
          tag_name: ${{ github.ref_name }}
          name: "Release ${{ github.ref_name }}"
          body: |
            ## Release ${{ github.ref_name }}
            Built from commit ${{ github.sha }}
          files: build/app/outputs/flutter-apk/app-release.apk
          draft: false
          prerelease: false
```

---

## How to Trigger a Release

### Prerequisites

Make sure the workflow file is committed and pushed to `main` **before** creating a tag:

```bash
git add .github/workflows/release.yml
git commit -m "add release workflow"
git push origin main
```

### Step-by-Step

```bash
# 1. Make sure your code is committed and pushed
git add .
git commit -m "your changes"
git push origin main

# 2. Create a version tag
git tag v1.0.0

# 3. Push the tag to GitHub (this triggers the workflow)
git push origin v1.0.0
```

> ⚠️ `git push` alone does **not** push tags. You must push the tag explicitly.

### Push commits and tag at the same time

```bash
git push origin main --tags
```

---

## Versioning Convention

Use [Semantic Versioning](https://semver.org/): `vMAJOR.MINOR.PATCH`

| Tag | When to use |
|-----|-------------|
| `v1.0.0` | First stable release |
| `v1.0.1` | Bug fix |
| `v1.1.0` | New feature |
| `v2.0.0` | Breaking change |

---

## Where to Find the Release

```
GitHub Repo → Releases → vX.X.X → app-release.apk
```

Or directly download via URL:

```
https://github.com/<owner>/<repo>/releases/download/v1.0.0/app-release.apk
```

---

## Managing Tags

```bash
# List all tags
git tag

# Delete a tag locally and remotely (e.g. to re-trigger)
git tag -d v1.0.0
git push origin --delete v1.0.0

# Re-create and push
git tag v1.0.0
git push origin v1.0.0
```

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Workflow not triggered | Make sure you pushed the tag with `git push origin <tag>`, not just `git push` |
| `assembleProdRelease` not found | Remove `--flavor prod` from the build command if no flavors are defined in `build.gradle.kts` |
| Workflow file not found | Ensure `.github/workflows/release.yml` exists on the `main` branch |
| Workflow disabled | Go to Actions tab → find the workflow → click **Enable Workflow** |
| Permission denied on release | Add `permissions: contents: write` to the job |