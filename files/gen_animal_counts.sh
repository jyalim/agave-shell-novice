#!/bin/sh
# Generates files for the animal counts example in lesson 6 on scripting
#
# Example of a shell script that could be made more efficient with inner
# loop/full loop done by python/perl/not-the-shell
###

wd="data-shell/data/animal-counts"

animals=(
  anteater
  bear
  cat
  deer
  eagle
  fox
  gopher
  hedgehog 
  impala
  jaguar
  kangaroo
  lizard
  macaw
  newt
  ocelot
  peacock
  quail
  rabbit
  raccoon
  snake
  termite
  urchin
  vulture
  wombat
  xantus
  yak
  zebra
)

YEAR=2020
MONTH=02
START_DAY=1
FINAL_DAY=29

for day in $(seq $START_DAY $FINAL_DAY); do
  date=$(printf "${YEAR}-%02d-%02d" $MONTH $day)
  for hour in $(seq 0 23); do
    time=$(printf "%02d:00:00" $hour)
    prefix="${date}T${time}"
    ind=$(python -c "import numpy as np; print(int(np.random.rand()*${#animals[@]}))")
    animal=${animals[$ind]}
    count=$((RANDOM % 100))
    echo "${prefix},${animal},${count}"
  done > "${wd}/duty-observation-${date}.log"
done
