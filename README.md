# Fuzzy Software
This repository holds the source code and output files of the fuzzing procedure for the course Software Security.

## Build & Run

Requirements are docker and git-lfs.

```bash
git-lfs install && git-lfs pull
docker build -t "fuzzy-vm" .
```

### Run the docker image

```bash
docker run -it fuzzy-vm
```

###

Run zzuf commando inside the docker image with 100 seeds for interesting output:

```bash
zzuf -C 100 -s 0:100 -x | flacon -s orig.cue
```

## Sources used

https://owasp.org/www-community/Fuzzing

http://caca.zoy.org/wiki/zzuf

### Submodules

https://github.com/samhocevar/zzuf

https://github.com/flacon/flacon

https://github.com/AFLplusplus/AFLplusplus

https://gitlab.com/akihe/radamsa


