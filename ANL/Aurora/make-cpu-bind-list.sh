#!/bin/bash

# number of processes desired
ranks=${1:-1}

# make a list of cores for each socket
socket0=()
socket1=()
for ((i=1; i <= 51; i++)); do
    socket0+=("$i" "$((i+104))")
    socket1+=("$((i+52))" "$((i+156))")
done

if [ "${ranks}" -eq 1 ]; then
    IFS=","
    echo "list:${socket0[*]},${socket1[*]}"
    IFS=
    exit 0
fi

if [ "$((ranks % 2))" -ne 0 ]; then
    printf "Number of ranks (%d) should be either 1 or divisible by 2" "${ranks}" 1>&2
    exit 1
fi

ranks_per_socket=$((ranks/2))
cores_per_rank=$((51/ranks_per_socket))
threads_per_rank=$(( cores_per_rank * 2 ))

printf "list:"
for ((i=0; i < ranks_per_socket; i++)); do
    IFS=","
    s=$(( i * threads_per_rank))
    printf "%s:" "${socket0[*]:s:threads_per_rank}"
done
for ((i=0; i < ranks_per_socket; i++)); do
    IFS=","
    s=$(( i * threads_per_rank ))
    printf "%s" "${socket1[*]:s:threads_per_rank}"
    if [ "$i" -ne "$((ranks_per_socket-1))" ]; then
        printf ":"
    fi
done
