# haukeschnau.de

Personal website built with Astro and Tailwind CSS.

## Development

```bash
bun install
bun run dev
```

## Nix

Build the static site package:

```bash
nix build .#site
```

`packages.default` points at the same output, so `nix build` also works.

Build the layered OCI image on Linux:

```bash
nix build .#image-site
```

The image is a Docker-compatible tarball produced with `dockerTools.buildLayeredImage`
and serves the static Astro output with Caddy.

## Dependency Hashes

The Bun dependency closure is pinned through `depsHashBySystem` in
`nix/site.nix`.

Print the current-system hash:

```bash
nix run .#update-deps -- site
```

Compute and write the hash for the current system:

```bash
nix run .#update-deps -- site --write
```

When `bun.lock` changes, update the hash for each target system that should build
this repository.
