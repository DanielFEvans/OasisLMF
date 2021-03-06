#!/bin/bash

rm -R -f output/*
rm -R -f work/*

mkdir work/kat
mkdir -p /tmp/AK6zUgU5HU/fifo
mkfifo /tmp/AK6zUgU5HU/fifo/gul_P1

mkfifo /tmp/AK6zUgU5HU/fifo/gul_S1_summary_P1
mkfifo /tmp/AK6zUgU5HU/fifo/gul_S1_summaryeltcalc_P1
mkfifo /tmp/AK6zUgU5HU/fifo/gul_S1_eltcalc_P1
mkfifo /tmp/AK6zUgU5HU/fifo/gul_S1_summarysummarycalc_P1
mkfifo /tmp/AK6zUgU5HU/fifo/gul_S1_summarycalc_P1
mkfifo /tmp/AK6zUgU5HU/fifo/gul_S1_summarypltcalc_P1
mkfifo /tmp/AK6zUgU5HU/fifo/gul_S1_pltcalc_P1

mkdir work/gul_S1_summaryaalcalc
mkfifo /tmp/AK6zUgU5HU/fifo/il_P1

mkfifo /tmp/AK6zUgU5HU/fifo/il_S1_summary_P1
mkfifo /tmp/AK6zUgU5HU/fifo/il_S1_summaryeltcalc_P1
mkfifo /tmp/AK6zUgU5HU/fifo/il_S1_eltcalc_P1
mkfifo /tmp/AK6zUgU5HU/fifo/il_S1_summarysummarycalc_P1
mkfifo /tmp/AK6zUgU5HU/fifo/il_S1_summarycalc_P1
mkfifo /tmp/AK6zUgU5HU/fifo/il_S1_summarypltcalc_P1
mkfifo /tmp/AK6zUgU5HU/fifo/il_S1_pltcalc_P1

mkdir work/il_S1_summaryaalcalc
mkfifo /tmp/AK6zUgU5HU/fifo/ri_P1

mkfifo /tmp/AK6zUgU5HU/fifo/ri_S1_summary_P1
mkfifo /tmp/AK6zUgU5HU/fifo/ri_S1_summaryeltcalc_P1
mkfifo /tmp/AK6zUgU5HU/fifo/ri_S1_eltcalc_P1
mkfifo /tmp/AK6zUgU5HU/fifo/ri_S1_summarysummarycalc_P1
mkfifo /tmp/AK6zUgU5HU/fifo/ri_S1_summarycalc_P1
mkfifo /tmp/AK6zUgU5HU/fifo/ri_S1_summarypltcalc_P1
mkfifo /tmp/AK6zUgU5HU/fifo/ri_S1_pltcalc_P1

mkdir work/ri_S1_summaryleccalc
mkdir work/ri_S1_summaryaalcalc


# --- Do reinsurance loss computes ---

eltcalc < /tmp/AK6zUgU5HU/fifo/ri_S1_summaryeltcalc_P1 > work/kat/ri_S1_eltcalc_P1 & pid1=$!
summarycalctocsv < /tmp/AK6zUgU5HU/fifo/ri_S1_summarysummarycalc_P1 > work/kat/ri_S1_summarycalc_P1 & pid2=$!
pltcalc < /tmp/AK6zUgU5HU/fifo/ri_S1_summarypltcalc_P1 > work/kat/ri_S1_pltcalc_P1 & pid3=$!

tee < /tmp/AK6zUgU5HU/fifo/ri_S1_summary_P1 /tmp/AK6zUgU5HU/fifo/ri_S1_summaryeltcalc_P1 /tmp/AK6zUgU5HU/fifo/ri_S1_summarypltcalc_P1 /tmp/AK6zUgU5HU/fifo/ri_S1_summarysummarycalc_P1 work/ri_S1_summaryaalcalc/P1.bin work/ri_S1_summaryleccalc/P1.bin > /dev/null & pid4=$!
summarycalc -f -p RI_1 -1 /tmp/AK6zUgU5HU/fifo/ri_S1_summary_P1 < /tmp/AK6zUgU5HU/fifo/ri_P1 &

# --- Do insured loss computes ---

eltcalc < /tmp/AK6zUgU5HU/fifo/il_S1_summaryeltcalc_P1 > work/kat/il_S1_eltcalc_P1 & pid5=$!
summarycalctocsv < /tmp/AK6zUgU5HU/fifo/il_S1_summarysummarycalc_P1 > work/kat/il_S1_summarycalc_P1 & pid6=$!
pltcalc < /tmp/AK6zUgU5HU/fifo/il_S1_summarypltcalc_P1 > work/kat/il_S1_pltcalc_P1 & pid7=$!

tee < /tmp/AK6zUgU5HU/fifo/il_S1_summary_P1 /tmp/AK6zUgU5HU/fifo/il_S1_summaryeltcalc_P1 /tmp/AK6zUgU5HU/fifo/il_S1_summarypltcalc_P1 /tmp/AK6zUgU5HU/fifo/il_S1_summarysummarycalc_P1 work/il_S1_summaryaalcalc/P1.bin > /dev/null & pid8=$!
summarycalc -f  -1 /tmp/AK6zUgU5HU/fifo/il_S1_summary_P1 < /tmp/AK6zUgU5HU/fifo/il_P1 &

# --- Use Ktools per process memory limit ---

ulimit -v $(ktgetmem 1)

# --- Do ground up loss computes ---

eltcalc < /tmp/AK6zUgU5HU/fifo/gul_S1_summaryeltcalc_P1 > work/kat/gul_S1_eltcalc_P1 & pid9=$!
summarycalctocsv < /tmp/AK6zUgU5HU/fifo/gul_S1_summarysummarycalc_P1 > work/kat/gul_S1_summarycalc_P1 & pid10=$!
pltcalc < /tmp/AK6zUgU5HU/fifo/gul_S1_summarypltcalc_P1 > work/kat/gul_S1_pltcalc_P1 & pid11=$!

tee < /tmp/AK6zUgU5HU/fifo/gul_S1_summary_P1 /tmp/AK6zUgU5HU/fifo/gul_S1_summaryeltcalc_P1 /tmp/AK6zUgU5HU/fifo/gul_S1_summarypltcalc_P1 /tmp/AK6zUgU5HU/fifo/gul_S1_summarysummarycalc_P1 work/gul_S1_summaryaalcalc/P1.bin > /dev/null & pid12=$!
summarycalc -g  -1 /tmp/AK6zUgU5HU/fifo/gul_S1_summary_P1 < /tmp/AK6zUgU5HU/fifo/gul_P1 &

eve 1 1 | getmodel | gulcalc -S0 -L0 -r -c /tmp/AK6zUgU5HU/fifo/gul_P1 -i - | fmcalc -a 2 | tee /tmp/AK6zUgU5HU/fifo/il_P1 | fmcalc -a 2 -n -p RI_1 > /tmp/AK6zUgU5HU/fifo/ri_P1 &

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


# --- Remove per process memory limit ---

ulimit -v $(ktgetmem 1)

aalcalc -Kri_S1_summaryaalcalc > output/ri_S1_aalcalc.csv & lpid1=$!
leccalc -r -Kri_S1_summaryleccalc -F output/ri_S1_leccalc_full_uncertainty_aep.csv -f output/ri_S1_leccalc_full_uncertainty_oep.csv -S output/ri_S1_leccalc_sample_mean_aep.csv -s output/ri_S1_leccalc_sample_mean_oep.csv -W output/ri_S1_leccalc_wheatsheaf_aep.csv -M output/ri_S1_leccalc_wheatsheaf_mean_aep.csv -m output/ri_S1_leccalc_wheatsheaf_mean_oep.csv -w output/ri_S1_leccalc_wheatsheaf_oep.csv & lpid2=$!
aalcalc -Kil_S1_summaryaalcalc > output/il_S1_aalcalc.csv & lpid3=$!
aalcalc -Kgul_S1_summaryaalcalc > output/gul_S1_aalcalc.csv & lpid4=$!
wait $lpid1 $lpid2 $lpid3 $lpid4

rm /tmp/AK6zUgU5HU/fifo/gul_P1

rm /tmp/AK6zUgU5HU/fifo/gul_S1_summary_P1
rm /tmp/AK6zUgU5HU/fifo/gul_S1_summaryeltcalc_P1
rm /tmp/AK6zUgU5HU/fifo/gul_S1_eltcalc_P1
rm /tmp/AK6zUgU5HU/fifo/gul_S1_summarysummarycalc_P1
rm /tmp/AK6zUgU5HU/fifo/gul_S1_summarycalc_P1
rm /tmp/AK6zUgU5HU/fifo/gul_S1_summarypltcalc_P1
rm /tmp/AK6zUgU5HU/fifo/gul_S1_pltcalc_P1

rm -rf work/kat
rm -rf work/gul_S1_summaryaalcalc/*
rmdir work/gul_S1_summaryaalcalc

rm /tmp/AK6zUgU5HU/fifo/ri_P1

rm /tmp/AK6zUgU5HU/fifo/ri_S1_summary_P1
rm /tmp/AK6zUgU5HU/fifo/ri_S1_summaryeltcalc_P1
rm /tmp/AK6zUgU5HU/fifo/ri_S1_eltcalc_P1
rm /tmp/AK6zUgU5HU/fifo/ri_S1_summarysummarycalc_P1
rm /tmp/AK6zUgU5HU/fifo/ri_S1_summarycalc_P1
rm /tmp/AK6zUgU5HU/fifo/ri_S1_summarypltcalc_P1
rm /tmp/AK6zUgU5HU/fifo/ri_S1_pltcalc_P1

rm -rf work/kat
rm work/ri_S1_summaryleccalc/*
rmdir work/ri_S1_summaryleccalc
rm -rf work/ri_S1_summaryaalcalc/*
rmdir work/ri_S1_summaryaalcalc
rm /tmp/AK6zUgU5HU/fifo/il_P1

rm /tmp/AK6zUgU5HU/fifo/il_S1_summary_P1
rm /tmp/AK6zUgU5HU/fifo/il_S1_summaryeltcalc_P1
rm /tmp/AK6zUgU5HU/fifo/il_S1_eltcalc_P1
rm /tmp/AK6zUgU5HU/fifo/il_S1_summarysummarycalc_P1
rm /tmp/AK6zUgU5HU/fifo/il_S1_summarycalc_P1
rm /tmp/AK6zUgU5HU/fifo/il_S1_summarypltcalc_P1
rm /tmp/AK6zUgU5HU/fifo/il_S1_pltcalc_P1

rm -rf work/kat
rm -rf work/il_S1_summaryaalcalc/*
rmdir work/il_S1_summaryaalcalc
rm /tmp/AK6zUgU5HU/fifo/*
rmdir /tmp/AK6zUgU5HU/fifo
rmdir /tmp/AK6zUgU5HU/
