#!/bin/bash

echo "Number of hkl files"
find . -name "*.hkl" | grep -v -e spiketrain -e mountains | wc -l

echo "Number of mda files"
find mountains -name "firings.mda" | wc -l

echo ""
echo "#==========================================================="
echo "Start Times"

# Print first timestamp in each SLURM output file (rpl + rs1-4)
for f in rpl*slurm*.out rs[1-4]*slurm*.out; do
    [ -e "$f" ] || continue   # skip if no match
    echo "==> $f <=="
    grep "time.struct_time" "$f" | head -n 1
done

echo "End Times"

# Print last timestamp, elapsed time, and MessageId (rpl + rs1-4)
for f in rpl*slurm*.out rs[1-4]*slurm*.out; do
    [ -e "$f" ] || continue
    echo "==> $f <=="
    grep "time.struct_time" "$f" | tail -n 1
    grep "^[0-9]\+\.[0-9]\+" "$f" | tail -n 1
    grep -A1 '"MessageId"' "$f"
done

echo "#==========================================================="

