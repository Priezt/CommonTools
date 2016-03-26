#!/bin/bash

find ~/.jrss -mtime +180 | xargs -I , rm ,

