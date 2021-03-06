#!/bin/bash

rm -R -f output/*
rm -R -f work/*

mkdir work/kat
mkdir -p /tmp/GS9BVbclP8/fifo
mkfifo /tmp/GS9BVbclP8/fifo/gul_P1

mkfifo /tmp/GS9BVbclP8/fifo/gul_S1_summary_P1
mkfifo /tmp/GS9BVbclP8/fifo/gul_S1_summaryeltcalc_P1
mkfifo /tmp/GS9BVbclP8/fifo/gul_S1_eltcalc_P1
mkfifo /tmp/GS9BVbclP8/fifo/gul_S1_summarysummarycalc_P1
mkfifo /tmp/GS9BVbclP8/fifo/gul_S1_summarycalc_P1
mkfifo /tmp/GS9BVbclP8/fifo/gul_S1_summarypltcalc_P1
mkfifo /tmp/GS9BVbclP8/fifo/gul_S1_pltcalc_P1

mkdir work/gul_S1_summaryaalcalc
mkfifo /tmp/GS9BVbclP8/fifo/il_P1

mkfifo /tmp/GS9BVbclP8/fifo/il_S1_summary_P1
mkfifo /tmp/GS9BVbclP8/fifo/il_S1_summaryeltcalc_P1
mkfifo /tmp/GS9BVbclP8/fifo/il_S1_eltcalc_P1
mkfifo /tmp/GS9BVbclP8/fifo/il_S1_summarysummarycalc_P1
mkfifo /tmp/GS9BVbclP8/fifo/il_S1_summarycalc_P1
mkfifo /tmp/GS9BVbclP8/fifo/il_S1_summarypltcalc_P1
mkfifo /tmp/GS9BVbclP8/fifo/il_S1_pltcalc_P1

mkdir work/il_S1_summaryaalcalc
mkfifo /tmp/GS9BVbclP8/fifo/ri_P1

mkfifo /tmp/GS9BVbclP8/fifo/ri_S1_summary_P1
mkfifo /tmp/GS9BVbclP8/fifo/ri_S1_summaryeltcalc_P1
mkfifo /tmp/GS9BVbclP8/fifo/ri_S1_eltcalc_P1
mkfifo /tmp/GS9BVbclP8/fifo/ri_S1_summarysummarycalc_P1
mkfifo /tmp/GS9BVbclP8/fifo/ri_S1_summarycalc_P1
mkfifo /tmp/GS9BVbclP8/fifo/ri_S1_summarypltcalc_P1
mkfifo /tmp/GS9BVbclP8/fifo/ri_S1_pltcalc_P1

mkdir work/ri_S1_summaryaalcalc


# --- Do reinsurance loss computes ---

eltcalc < /tmp/GS9BVbclP8/fifo/ri_S1_summaryeltcalc_P1 > work/kat/ri_S1_eltcalc_P1 & pid1=$!
summarycalctocsv < /tmp/GS9BVbclP8/fifo/ri_S1_summarysummarycalc_P1 > work/kat/ri_S1_summarycalc_P1 & pid2=$!
pltcalc < /tmp/GS9BVbclP8/fifo/ri_S1_summarypltcalc_P1 > work/kat/ri_S1_pltcalc_P1 & pid3=$!

tee < /tmp/GS9BVbclP8/fifo/ri_S1_summary_P1 /tmp/GS9BVbclP8/fifo/ri_S1_summaryeltcalc_P1 /tmp/GS9BVbclP8/fifo/ri_S1_summarypltcalc_P1 /tmp/GS9BVbclP8/fifo/ri_S1_summarysummarycalc_P1 work/ri_S1_summaryaalcalc/P1.bin > /dev/null & pid4=$!
summarycalc -f -p RI_1 -1 /tmp/GS9BVbclP8/fifo/ri_S1_summary_P1 < /tmp/GS9BVbclP8/fifo/ri_P1 &

# --- Do insured loss computes ---

eltcalc < /tmp/GS9BVbclP8/fifo/il_S1_summaryeltcalc_P1 > work/kat/il_S1_eltcalc_P1 & pid5=$!
summarycalctocsv < /tmp/GS9BVbclP8/fifo/il_S1_summarysummarycalc_P1 > work/kat/il_S1_summarycalc_P1 & pid6=$!
pltcalc < /tmp/GS9BVbclP8/fifo/il_S1_summarypltcalc_P1 > work/kat/il_S1_pltcalc_P1 & pid7=$!

tee < /tmp/GS9BVbclP8/fifo/il_S1_summary_P1 /tmp/GS9BVbclP8/fifo/il_S1_summaryeltcalc_P1 /tmp/GS9BVbclP8/fifo/il_S1_summarypltcalc_P1 /tmp/GS9BVbclP8/fifo/il_S1_summarysummarycalc_P1 work/il_S1_summaryaalcalc/P1.bin > /dev/null & pid8=$!
summarycalc -f  -1 /tmp/GS9BVbclP8/fifo/il_S1_summary_P1 < /tmp/GS9BVbclP8/fifo/il_P1 &

# --- Do ground up loss computes ---

eltcalc < /tmp/GS9BVbclP8/fifo/gul_S1_summaryeltcalc_P1 > work/kat/gul_S1_eltcalc_P1 & pid9=$!
summarycalctocsv < /tmp/GS9BVbclP8/fifo/gul_S1_summarysummarycalc_P1 > work/kat/gul_S1_summarycalc_P1 & pid10=$!
pltcalc < /tmp/GS9BVbclP8/fifo/gul_S1_summarypltcalc_P1 > work/kat/gul_S1_pltcalc_P1 & pid11=$!

tee < /tmp/GS9BVbclP8/fifo/gul_S1_summary_P1 /tmp/GS9BVbclP8/fifo/gul_S1_summaryeltcalc_P1 /tmp/GS9BVbclP8/fifo/gul_S1_summarypltcalc_P1 /tmp/GS9BVbclP8/fifo/gul_S1_summarysummarycalc_P1 work/gul_S1_summaryaalcalc/P1.bin > /dev/null & pid12=$!
summarycalc -g  -1 /tmp/GS9BVbclP8/fifo/gul_S1_summary_P1 < /tmp/GS9BVbclP8/fifo/gul_P1 &

eve 1 1 | getmodel | gulcalc -S0 -L0 -r -c /tmp/GS9BVbclP8/fifo/gul_P1 -i - | fmcalc -a 2 | tee /tmp/GS9BVbclP8/fifo/il_P1 | fmcalc -a 2 -n -p RI_1 > /tmp/GS9BVbclP8/fifo/ri_P1 &

wait $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9 $pid10 $pid11 $pid12


# --- Do reinsurance loss kats ---

kat work/kat/ri_S1_eltcalc_P1 > output/ri_S1_eltcalc.csv & kpid1=$!
kat work/kat/ri_S1_pltcalc_P1 > output/ri_S1_pltcalc.csv & kpid2=$!
kat work/kat/ri_S1_summarycalc_P1 > output/ri_S1_summarycalc.csv & kpid3=$!

# --- Do insured loss kats ---

kat work/kat/il_S1_eltcalc_P1 > output/il_S1_eltcalc.csv & kpid4=$!
kat work/kat/il_S1_pltcalc_P1 > output/il_S1_pltcalc.csv & kpid5=$!
kat work/kat/il_S1_summarycalc_P1 > output/il_S1_summarycalc.csv & kpid6=$!

# --- Do ground up loss kats ---

kat work/kat/gul_S1_eltcalc_P1 > output/gul_S1_eltcalc.csv & kpid7=$!
kat work/kat/gul_S1_pltcalc_P1 > output/gul_S1_pltcalc.csv & kpid8=$!
kat work/kat/gul_S1_summarycalc_P1 > output/gul_S1_summarycalc.csv & kpid9=$!
wait $kpid1 $kpid2 $kpid3 $kpid4 $kpid5 $kpid6 $kpid7 $kpid8 $kpid9


aalcalc -Kri_S1_summaryaalcalc > output/ri_S1_aalcalc.csv & lpid1=$!
aalcalc -Kil_S1_summaryaalcalc > output/il_S1_aalcalc.csv & lpid2=$!
aalcalc -Kgul_S1_summaryaalcalc > output/gul_S1_aalcalc.csv & lpid3=$!
wait $lpid1 $lpid2 $lpid3

rm /tmp/GS9BVbclP8/fifo/gul_P1

rm /tmp/GS9BVbclP8/fifo/gul_S1_summary_P1
rm /tmp/GS9BVbclP8/fifo/gul_S1_summaryeltcalc_P1
rm /tmp/GS9BVbclP8/fifo/gul_S1_eltcalc_P1
rm /tmp/GS9BVbclP8/fifo/gul_S1_summarysummarycalc_P1
rm /tmp/GS9BVbclP8/fifo/gul_S1_summarycalc_P1
rm /tmp/GS9BVbclP8/fifo/gul_S1_summarypltcalc_P1
rm /tmp/GS9BVbclP8/fifo/gul_S1_pltcalc_P1

rm -rf work/kat
rm -rf work/gul_S1_summaryaalcalc/*
rmdir work/gul_S1_summaryaalcalc

rm /tmp/GS9BVbclP8/fifo/ri_P1

rm /tmp/GS9BVbclP8/fifo/ri_S1_summary_P1
rm /tmp/GS9BVbclP8/fifo/ri_S1_summaryeltcalc_P1
rm /tmp/GS9BVbclP8/fifo/ri_S1_eltcalc_P1
rm /tmp/GS9BVbclP8/fifo/ri_S1_summarysummarycalc_P1
rm /tmp/GS9BVbclP8/fifo/ri_S1_summarycalc_P1
rm /tmp/GS9BVbclP8/fifo/ri_S1_summarypltcalc_P1
rm /tmp/GS9BVbclP8/fifo/ri_S1_pltcalc_P1

rm -rf work/kat
rm -rf work/ri_S1_summaryaalcalc/*
rmdir work/ri_S1_summaryaalcalc
rm /tmp/GS9BVbclP8/fifo/il_P1

rm /tmp/GS9BVbclP8/fifo/il_S1_summary_P1
rm /tmp/GS9BVbclP8/fifo/il_S1_summaryeltcalc_P1
rm /tmp/GS9BVbclP8/fifo/il_S1_eltcalc_P1
rm /tmp/GS9BVbclP8/fifo/il_S1_summarysummarycalc_P1
rm /tmp/GS9BVbclP8/fifo/il_S1_summarycalc_P1
rm /tmp/GS9BVbclP8/fifo/il_S1_summarypltcalc_P1
rm /tmp/GS9BVbclP8/fifo/il_S1_pltcalc_P1

rm -rf work/kat
rm -rf work/il_S1_summaryaalcalc/*
rmdir work/il_S1_summaryaalcalc
rm /tmp/GS9BVbclP8/fifo/*
rmdir /tmp/GS9BVbclP8/fifo
rmdir /tmp/GS9BVbclP8/
