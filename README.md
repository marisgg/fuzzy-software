---
---

# Fuzzy Software
This repository holds the source code and output files of the fuzzing procedure for the course Software Security.

---

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

---

### Fuzzing

* _zzuf_

Run zzuf command inside the docker image with 100 seeds for interesting output:

```bash
zzuf -C 100 -s 0:100 -x flacon -s orig.cue
```

* _radamsa_

Running radamsa is done as follows:

```bash
cat orig.cue | radamsa > ram.cue && flacon -s ram.cue
```

#### Segfault

* Run zzuf with seed 12331 or with the 'seg.cue' file in the repository to see a signal 11 SEGV.

* Run radam.py for a fresh segfault; run ramseg\_gen10.sh for 10.

---

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

---

# Results

Using zzuf with seed 12331, we generated seg.cue which results in a segmentation fault when giving this as input file to Flacon. We found that Flacon's pitfall is the replacement of the space right after FILE with another character. The CUE file can be truncated to the first 10 lines (head -10) to produce this same segmentation fault. Experimental results tell us that the spooky space can be replaced with any character followed by any amount of additional characters on the same line to produce this error.

