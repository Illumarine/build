# Illumarine Build Scripts

Work-in-progress build systems for Illumarine.

## Usage

If files are not in places the script will immediately expect, run the following command.

```sh
sh ./build -b /path/to/build -p /path/to/illumos-gate/proto/root_i386
```

Where it links this build directory, and your illumos-gate directory.

If the files are placed in these places...

```sh
${HOME}/build # for this directory
${HOME}/illumos-gate/proto/root_i386 # for your illumos-gate build
```

... then theoretically you can run `sh ./build` by itself, with no issues. Still, use the more verbose command just to be safe.

Other options

- `-o` is for output ISO file name/path (ex: `-o /root/myillumarine.iso`)

## Contributing

### Directory Structure

- `./iso` is for ISO related things, such as final build scripts
- `./packages` is for software unpacking and installation into PROTO
