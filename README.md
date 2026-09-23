# MikroTik HotSpot Login Page

Custom captive portal / HotSpot login page for MikroTik RouterOS.

## Project structure

- `hotspotV3/` — main HotSpot portal files
- `hotspotV3/js/` — JavaScript modules and local libraries
- `hotspotV3/css/` — portal styles
- `index.html` — project launcher
- `hotspotV3/demo.html` — frontend demo for browser/GitHub Pages testing

## Notes

The files under `hotspotV3/` are designed to be used with MikroTik HotSpot variables such as `$(link-login-only)`, `$(chap-id)`, and `$(chap-challenge)`.

The demo page is a browser-only frontend playground and does not emulate the MikroTik HotSpot server.

## Development

For local development on Termux, the repository is kept in sync with the `main` branch.

Repository: https://github.com/BoyOs04/login-page-hotspot-ryo
