#!/bin/bash

find ~/.fresh -mtime +180 | xargs -I , rm ,

