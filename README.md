# Fuzzy Software
This repository holds the source code and output files of the fuzzing procedure for the course Software Security.

## Build & Run

Requirement is docker.

Default image (no instrumentation):

```bash
docker build -t "fuzzy-vm" .
```

Instrumented image:

```bash
docker build -f InstrumentedFlacon.dockerfile -t "fuzzy-vm-inst"
```

### Run the docker image

Default image:

```bash
docker run -it fuzzy-vm
```

Instrumented image:

```bash
docker run -it fuzzy-vm-inst
```

### Fuzzing

Run zzuf commando inside the docker image with 100 seeds for interesting output:

```bash
zzuf -C 100 -s 0:100 -x flacon -s orig.cue
```

#### Segfault

Run zzuf with seed 12331 or with the 'seg.cue' file in the repository to see a signal 11 SEGV.

## Sources used

https://owasp.org/www-community/Fuzzing

http://caca.zoy.org/wiki/zzuf

https://github.com/google/sanitizers/wiki/AddressSanitizer

https://www.usenix.org/system/files/login/articles/login_summer16_03_gutmann.pdf

https://aflplus.plus/building/

### Submodules

https://github.com/samhocevar/zzuf

https://github.com/flacon/flacon

https://github.com/AFLplusplus/AFLplusplus

https://gitlab.com/akihe/radamsa


