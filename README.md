# MikroTik HotSpot Login Page

Custom captive portal / HotSpot login page for MikroTik RouterOS.

## Repository

- GitHub: https://github.com/BoyOs04/login-page-hotspot-ryo
- Main branch: `main`
- Main portal folder: `hotspotV3/`

---

# 1. Project structure

```text
.
├── hotspotV3/              ← files for MikroTik HotSpot
│   ├── login.html
│   ├── main.html
│   ├── status.html
│   ├── qr.html
│   ├── alogin.html
│   ├── radvert.html
│   ├── logout.html
│   ├── error.html
│   ├── redirect.html
│   ├── api.json
│   ├── md5.js
│   ├── css/
│   └── js/
├── index.html              ← repository/browser launcher
├── css/                    ← repository launcher styles
├── js/                     ← repository launcher scripts
├── termux-setup.sh         ← Termux shortcut/recovery setup
├── make-hotspot-release.sh ← creates MikroTik-only ZIP
└── README.md
```

The **MikroTik deployment payload is the `hotspotV3/` directory**.

The root `index.html`, root `css/`, root `js/`, README, Termux scripts, and development/demo files are not required by MikroTik to serve the HotSpot portal.

---

# 2. What to download for MikroTik

For normal MikroTik installation, download **only the HotSpot portal payload**:

```text
hotspotV3/
```

Do **not** download or upload the entire repository to the router.

The deployment tree should look like:

```text
MikroTik
└── Files
    └── hotspot/
        ├── login.html
        ├── main.html
        ├── status.html
        ├── qr.html
        ├── alogin.html
        ├── radvert.html
        ├── logout.html
        ├── error.html
        ├── redirect.html
        ├── api.json
        ├── md5.js
        ├── css/
        └── js/
```

Keep the internal `css/` and `js/` directories intact.

### Files that are development-only

These are useful for development but are **not part of the MikroTik HotSpot deployment**:

```text
README.md
index.html
css/
js/
termux-setup.sh
make-hotspot-release.sh
hotspotV3/demo.html
```

The release package also excludes `hotspotV3/demo.html` because it is a browser-only frontend test page, not a MikroTik HotSpot page.

---

# 3. Release package

A release package can be created containing only the MikroTik deployment files.

The repository includes:

```text
make-hotspot-release.sh
```

From Termux, run:

```bash
hotspot
bash make-hotspot-release.sh v1.0.0
```

The ZIP is created outside the repository by default:

```text
$HOME/hotspotV3-v1.0.0.zip
```

Its contents are based only on:

```text
hotspotV3/
```

with `hotspotV3/demo.html` excluded.

You can choose another version:

```bash
bash make-hotspot-release.sh v1.0.1
```

or specify the output path:

```bash
bash make-hotspot-release.sh v1.0.0 $HOME/storage/downloads/hotspotV3-v1.0.0.zip
```

The ZIP should be uploaded to the MikroTik **Files** directory after extracting it, or extracted locally first and then its contents uploaded to the HotSpot HTML directory.

### GitHub Release

GitHub Releases are also suitable for distributing the ZIP.

Recommended asset name:

```text
hotspotV3-v1.0.0.zip
```

The release asset should contain only the MikroTik portal payload described above.

GitHub's normal repository **Code → Download ZIP** archive contains the whole repository, so it is not the correct download method when the goal is a clean MikroTik deployment package.

The release ZIP is intentionally separate from the Git source repository so README, Termux tooling, launcher files, and development files do not need to be copied to the router.

---

# 4. Requirements

You need:

- MikroTik RouterOS with HotSpot enabled
- A HotSpot server/profile
- A HotSpot user for testing
- Git
- Termux if developing from Android
- WinBox/WebFig/SSH/FTP/SFTP access to the MikroTik router

The portal uses RouterOS HotSpot variables such as:

```text
$(link-login-only)
$(link-login)
$(link-orig)
$(chap-id)
$(chap-challenge)
$(session-timeout-secs)
$(remain-bytes-total)
$(limit-bytes-total)
```

Do not test the production portal by opening the raw HTML directly in a normal browser and expecting RouterOS variables to work. RouterOS replaces these variables when it serves the HotSpot files.

---

# 5. Using the custom HTML login page on MikroTik

## Step 1 — Enable HotSpot

If HotSpot has not been configured yet, create/configure it first.

In WinBox:

```text
IP
└── Hotspot
    ├── Servers
    ├── Server Profiles
    └── Users
```

Make sure a HotSpot server is running on the interface where clients connect.

---

## Step 2 — Prepare the portal files

The files that need to be served by MikroTik are inside:

```text
hotspotV3/
```

Keep the directory structure intact.

For example:

```text
hotspotV3/
├── login.html
├── main.html
├── status.html
├── qr.html
├── css/
└── js/
```

Do not randomly move JavaScript/CSS files because the HTML files reference them using relative paths.

---

## Step 3 — Upload the HotSpot folder to MikroTik

Open WinBox/WebFig and go to **Files**.

The HotSpot files are normally stored in the router's HotSpot directory, commonly:

```text
/hotspot/
```

Back up the existing files first.

Then upload the **contents of `hotspotV3/`** to the router's HotSpot directory.

The important result is that MikroTik can access:

```text
/hotspot/login.html
/hotspot/main.html
/hotspot/status.html
/hotspot/qr.html
/hotspot/css/...
/hotspot/js/...
```

If your RouterOS installation uses a different HotSpot HTML directory, use the directory shown by **Files** and your existing HotSpot configuration.

### Important

Do not upload the entire Git repository as the HotSpot directory.

Upload the **contents of `hotspotV3/`**, not the repository root.

---

# 6. Configure the HotSpot profile

Go to:

```text
IP → Hotspot → Server Profiles
```

Select the profile used by your HotSpot server.

Set:

```text
HTML Directory = hotspot
```

If you use a custom directory name, make sure it matches the actual directory containing `login.html`.

You can also inspect it from Terminal/SSH:

```routeros
/ip hotspot profile print
/ip hotspot print
```

---

# 7. HTTP-CHAP login

This project supports the RouterOS HTTP-CHAP flow.

For initial testing, the HotSpot profile can allow both:

```text
http-chap,http-pap
```

Example:

```routeros
/ip hotspot profile
set [find name="NAMA-PROFILE"] login-by=http-chap,http-pap
```

The login page uses:

```text
$(chap-id)
$(chap-challenge)
```

and `md5.js` to generate the CHAP response.

The relevant files are:

```text
hotspotV3/login.html
hotspotV3/md5.js
```

After CHAP has been tested successfully, PAP can be disabled if it is not required:

```routeros
/ip hotspot profile
set [find name="NAMA-PROFILE"] login-by=http-chap
```

Always test with a non-critical HotSpot user before changing a production router.

---

# 8. Create a HotSpot user for testing

Example:

```routeros
/ip hotspot user
add name=test password=test123
```

Then connect a client to the HotSpot and open a website.

The captive portal should redirect the client to the custom:

```text
login.html
```

Enter:

```text
Username: test
Password: test123
```

If CHAP is enabled, the page handles the CHAP transformation before submitting the login request.

---

# 9. Test the login page

After uploading the files:

1. Connect your phone/PC to the HotSpot Wi-Fi.
2. Make sure the client receives an IP address from the HotSpot DHCP server.
3. Open a normal HTTP website to trigger captive-portal detection.
4. The router should redirect the client to `login.html`.
5. Test username/password login.
6. Test Quick Login if configured.
7. Test the status page after authentication.
8. Test logout.
9. Test QR login if the corresponding user is configured.

If the page is blank, check:

- `login.html` exists.
- CSS/JS files exist in the expected directories.
- File paths are correct.
- The HotSpot profile points to the correct HTML directory.
- The client can reach the router.
- Firewall/NAT rules are not interfering with the HotSpot.
- RouterOS is actually serving the custom HTML directory.

---

# 10. HotSpot page flow

The intended flow is approximately:

```text
Client
  │
  ▼
HotSpot
  │
  ▼
login.html
  │
  ├── normal login
  ├── HTTP-CHAP
  ├── Quick Login
  └── QR credentials
  │
  ▼
RouterOS authentication
  │
  ▼
main.html / status.html
```

The exact page shown after login depends on the RouterOS HotSpot variables and configuration.

---

# 11. Termux development setup

The repository can be managed directly from Android/Termux.

## Install Git

After installing/reinstalling Termux:

```bash
pkg update
pkg install git
```

Allow Android shared-storage access:

```bash
termux-setup-storage
```

Accept the Android permission prompt.

---

# 12. Clone the repository on a new Termux installation

Go to the web directory:

```bash
cd /storage/6661-3362/web
```

Clone:

```bash
git clone https://github.com/BoyOs04/login-page-hotspot-ryo.git github
```

Enter the repository:

```bash
cd github
```

If Git asks for authentication, authenticate using the GitHub credentials/token appropriate for your account. Never put a personal access token into this README or commit it into the repository.

---

# 13. Install the Termux shortcuts

This repository includes:

```text
termux-setup.sh
```

Run:

```bash
bash termux-setup.sh
```

The script configures:

- Git `safe.directory`
- repository shortcut
- GitHub → HP synchronization shortcut
- HP → GitHub synchronization shortcut
- sparse-checkout configuration

It is safe to run again after reinstalling Termux.

---

# 14. Termux shortcuts

## Enter the repository

```bash
hotspot
```

This changes the current directory to:

```text
/storage/6661-3362/web/github
```

---

## Synchronize GitHub → HP

```bash
sync-file-github
```

This runs a fast-forward-only pull from:

```text
origin/main
```

Example:

```text
GitHub
   │
   ▼
sync-file-github
   │
   ▼
HP / Termux
```

---

## Send HP → GitHub

```bash
push-file-github
```

The command automatically:

1. enters the repository
2. runs `git add .`
3. checks whether there are changes
4. creates a commit
5. pushes to `origin/main`

You can provide your own commit message:

```bash
push-file-github "Fix login page"
```

Without a message it uses:

```text
Update from HP
```

---

# 15. Recommended daily workflow

Before editing:

```bash
sync-file-github
```

Edit your files.

Check the changes:

```bash
git status
```

Send the changes:

```bash
push-file-github "Update login page"
```

The normal workflow is:

```text
GitHub
  │
  │ sync-file-github
  ▼
HP
  │
  │ edit
  ▼
HP
  │
  │ push-file-github
  ▼
GitHub
```

---

# 16. If Termux is accidentally deleted

Your GitHub repository remains the backup/source of truth.

After reinstalling Termux:

```bash
pkg update
pkg install git
termux-setup-storage

cd /storage/6661-3362/web

git clone https://github.com/BoyOs04/login-page-hotspot-ryo.git github

cd github

bash termux-setup.sh
```

After that:

```bash
hotspot
```

and the shortcuts are available again.

This means the shortcut configuration does not depend only on the old Termux installation.

---

# 17. README and sparse-checkout

The repository contains this README, but the Termux setup uses Git sparse-checkout so that `README.md` can remain tracked on GitHub without being checked out into the local working tree.

This is **not** the same as `.gitignore`.

### `.gitignore`

Prevents selected untracked files from being added to Git.

### Sparse-checkout

Controls which tracked files are present in the local working tree.

Therefore:

```text
GitHub:
README.md       ✓ tracked

Termux working tree:
README.md       intentionally omitted
```

The repository still retains the README on GitHub.

---

# 18. Updating the custom portal

After modifying the portal:

```bash
push-file-github "Update HotSpot portal"
```

On another device/Termux installation:

```bash
sync-file-github
```

Then upload the updated `hotspotV3/` contents to MikroTik.

Do not modify the MikroTik copy and assume GitHub will automatically know about those changes. The Git repository and the router filesystem are separate.

---

# 19. Backup before replacing MikroTik HotSpot files

Before installing a new version, keep a copy of the current router HotSpot directory.

For example:

```text
MikroTik
└── Files
    └── hotspot/
```

Copy the existing directory/files somewhere safe before replacing them.

This makes it possible to restore the previous portal if the new version has a problem.

---

# 20. Troubleshooting

## Login page is blank

Check:

```text
/hotspot/login.html
/hotspot/css/
/hotspot/js/
/hotspot/md5.js
```

Also verify the HTML directory in the HotSpot server profile.

---

## CHAP login does not work

Check:

```routeros
/ip hotspot profile print
```

For testing:

```routeros
/ip hotspot profile
set [find name="NAMA-PROFILE"] login-by=http-chap,http-pap
```

Then verify that `md5.js` is present beside `login.html`.

---

## CSS/JavaScript does not load

Check the paths in the browser page and the corresponding files under:

```text
/hotspot/css/
/hotspot/js/
```

Do not rename or move files without updating their references.

---

## Git says "dubious ownership"

Run:

```bash
git config --global --add safe.directory /storage/6661-3362/web/github
```

The `termux-setup.sh` script performs this automatically.

---

## GitHub and HP are different

Check:

```bash
git remote -v
git status
git branch --show-current
```

Expected remote:

```text
https://github.com/BoyOs04/login-page-hotspot-ryo.git
```

Expected branch:

```text
main
```

---

# 21. Important security notes

- Do not commit GitHub Personal Access Tokens.
- Do not publish router administrator passwords.
- Change example HotSpot passwords before production use.
- Do not assume frontend JavaScript can protect credentials.
- Use HTTPS where applicable for management interfaces.
- Keep RouterOS updated according to your maintenance policy.
- Test authentication changes before applying them to a production HotSpot.

---

# 22. Browser demo

The repository includes:

```text
hotspotV3/demo.html
```

The demo is intended for frontend testing in a normal browser.

It does **not** provide a real MikroTik authentication server.

RouterOS variables such as:

```text
$(link-login-only)
$(chap-id)
$(chap-challenge)
```

are processed by MikroTik when the actual HotSpot portal is served by RouterOS.

---

# 23. Development principle

Keep the following separation:

```text
GitHub repository
      │
      ▼
Termux / development
      │
      ▼
hotspotV3/
      │
      ▼
MikroTik HotSpot
```

GitHub is the version-controlled source.

Termux is the development/synchronization environment.

MikroTik is the deployment target.

A change in one location does not automatically change the other locations.

---

## Quick reference

```bash
# Enter project
hotspot

# GitHub -> HP
sync-file-github

# HP -> GitHub
push-file-github "Your commit message"

# Create MikroTik-only release ZIP
bash make-hotspot-release.sh v1.0.0

# Check Git status
git status

# Check branch
git branch --show-current

# Check GitHub remote
git remote -v
```
