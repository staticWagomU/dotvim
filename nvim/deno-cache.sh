#!/bin/bash

find ~/.local/share/nvim/site/pack/deps/ -type f -name "*.ts" | xargs deno cache -r
