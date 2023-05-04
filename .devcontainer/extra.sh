#!/bin/bash

set -uxe
set -o pipefail

(cd /tmp && sudo rm -rf gitflow && git clone https://github.com/datasift/gitflow && cd gitflow && sudo ./install.sh && sudo git hf upgrade)
sudo rm -rf /tmp/gitflow
