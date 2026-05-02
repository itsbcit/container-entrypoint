# container-entrypoint

A template for scripting container entrypoints with modular, drop-in shell scripts.

## How It Works

`container-entrypoint.sh` sources every `*.sh` script in `/container-entrypoint.d/` in order, then execs the container command. If the command is `init-loop`, it sleeps forever instead (useful for sidecar/init containers).

Entrypoint scripts are sourced, not executed as subshells, so they can modify the shell environment for subsequent scripts.

## Included Scripts

| Script | Purpose | Environment Variables |
|--------|---------|----------------------|
| `10-timezone.sh` | Sets the container timezone. | `TZ` — timezone name (e.g. `America/Vancouver`). |

## Usage

Use as a base image or copy the entrypoint into your own image:

```containerfile
FROM alpine:latest

COPY container-entrypoint.sh /container-entrypoint.sh
COPY container-entrypoint.d /container-entrypoint.d
RUN chmod 555 /container-entrypoint.sh

ENTRYPOINT [ "/container-entrypoint.sh" ]
```

## Adding Custom Scripts

Drop additional `*.sh` scripts into `/container-entrypoint.d/`. They are sourced in filename order, so use numeric prefixes to control execution order (e.g. `20-custom-setup.sh`).

## License

GPL-2.0
