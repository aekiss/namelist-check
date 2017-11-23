#!/usr/bin/env bash

mkdir -p raijin

nice time rsync -avPSRH aek156@r-dm.nci.org.au:/g/data3/hh5/tmp/cosima/access-om2/*/output*/*/*.nml ./raijin
nice time rsync -avPSRH aek156@r-dm.nci.org.au:/g/data3/hh5/tmp/cosima/access-om2-025/*/output*/*/*.nml ./raijin
nice time rsync -avPSRH aek156@r-dm.nci.org.au:/g/data3/hh5/tmp/cosima/access-om2-01/*/output*/*/*.nml ./raijin
