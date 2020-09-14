#!/bin/bash


echo -e '\n Tempos de transmissao dos veiculos: ' > relatorio.txt
head logcar{0..14}.txt  | grep -v ini | tr '\n' ' ' | sed 's/==>/\n==>/g' | cut -d' ' -f2,5 >> relatorio.txt

echo -e '\n Tempos de transmissao dos veiculos  consolidados (relativo): ' >> relatorio.txt
times=$(head logcar{0..14}.txt  | grep -v ini | tr '\n' ' ' | sed 's/==>/\n==>/g' | cut -d' ' -f5); t1=$(echo $times | cut -d' ' -f1); for t in $times; do echo $t-$t1 | bc; done >> relatorio.txt

echo -e '\n Tempos de transmissao dos veiculos  consolidados (global): ' >> relatorio.txt
for i in $(ls logcar*); do rm -f temp1.txt; rm -f temp2.txt; seg1=$(cat $i | grep ini | cut -d' ' -f2| cut -d'.' -f1); seg2=$(cat $i | grep transm | head -1 | cut -d' ' -f2| cut -d'.' -f1); k=$(($seg2 - $seg1)); echo $i $k; done >> relatorio.txt

echo -e  '\n Tempos de recepcao dos pacotes nos servidores - Server e: '  >> relatorio.txt
for i in {110..124}; do time=$(cat server_e.txt | tr -s ' ' | tr '\n' ' ' | sed 's/1470/1470\n/g' | grep 200.0.10.$i | head -1 | tr -s ' '| cut -d' ' -f2); echo 200.0.10.$i '->' $time; done >> relatorio.txt

echo -e '\n Tempos de recepcao dos pacotes nos servidores - Server e2: '  >> relatorio.txt 
for i in {110..124}; do time=$(cat server_e2.txt | tr -s ' ' | tr '\n' ' ' | sed 's/1470/1470\n/g' | grep 200.0.10.$i | head -1 | tr -s ' '| cut -d' ' -f2); echo 200.0.10.$i '->' $time; done >> relatorio.txt

echo -e  '\n Tempos de recepcao dos pacotes nos servidores - Server g: ' >> relatorio.txt 
for i in {110..124}; do time=$(cat server_g.txt | tr -s ' ' | tr '\n' ' ' | sed 's/1470/1470\n/g' | grep 200.0.10.$i | head -1 | tr -s ' '| cut -d' ' -f2); echo 200.0.10.$i '->' $time; done >> relatorio.txt

echo -e  '\n Tempos de recepcao dos pacotes nos servidores - Server s1: ' >> relatorio.txt
for i in {110..124}; do time=$(cat server_s1.txt | tr -s ' ' | tr '\n' ' ' | sed 's/1470/1470\n/g' | grep 200.0.10.$i | head -1 | tr -s ' '| cut -d' ' -f2); echo 200.0.10.$i '->' $time; done >> relatorio.txt

echo -e  >> '\n Tempos de recepcao dos pacotes nos servidores - Server s2: ' >> relatorio.txt
for i in {110..124}; do time=$(cat server_s2.txt | tr -s ' ' | tr '\n' ' ' | sed 's/1470/1470\n/g' | grep 200.0.10.$i | head -1 | tr -s ' '| cut -d' ' -f2); echo 200.0.10.$i '->' $time; done >> relatorio.txt

echo -e  >> '\n Tempos de recepcao dos pacotes nos servidores - Server s3: ' >> relatorio.txt
for i in {110..124}; do time=$(cat server_s3.txt | tr -s ' ' | tr '\n' ' ' | sed 's/1470/1470\n/g' | grep 200.0.10.$i | head -1 | tr -s ' '| cut -d' ' -f2); echo 200.0.10.$i '->' $time; done >> relatorio.txt

echo -e  '\n ============================== Tempos apos processamento dos resultados: =============================================== \n ' >> relatorio.txt 

echo -e '\n Transmissao veiculos FN - App_E - apos processamento:' >> relatorio.txt
for i in {110..124}; do time=$(cat result/cartf_fn_5003_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt 
echo -e '\n Recepcao server FN - App_E - apos processamento:' >> relatorio.txt
for i in {110..124}; do time=$(cat result/server_etf_car_fn_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt

echo -e '\n Transmissao veiculos FQ - App_E - apos processamento:' >> relatorio.txt 
for i in {110..124}; do time=$(cat result/cartf_fq_5003_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt 
echo -e '\n Recepcao server FQ - App_E - apos processamento:' >> relatorio.txt
for i in {110..124}; do time=$(cat result/server_etf_car_fq_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt

echo -e '\n Transmissao veiculos FS - App_E - apos processamento:' >> relatorio.txt 
for i in {110..124}; do time=$(cat result/cartf_fs_5003_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt 
echo -e '\n Recepcao server FS - App_E - apos processamento:' >> relatorio.txt
for i in {110..124}; do time=$(cat result/server_etf_car_fs_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt

echo -e '\n Transmissao veiculos FN - App_E2 - apos processamento:' >> relatorio.txt 
for i in {110..124}; do time=$(cat result/cartf_fn_5004_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt 
echo -e '\n Recepcao server FN - App_E2 - apos processamento:' >> relatorio.txt
for i in {110..124}; do time=$(cat result/server_e2tf_car_fn_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt

echo -e '\n Transmissao veiculos FQ - App_E2 - apos processamento:' >> relatorio.txt 
for i in {110..124}; do time=$(cat result/cartf_fq_5004_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt 
echo -e '\n Recepcao server FQ - App_E2 - apos processamento:' >> relatorio.txt
for i in {110..124}; do time=$(cat result/server_e2tf_car_fq_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt

echo -e '\n Transmissao veiculos FS - App_E2 - apos processamento:' >> relatorio.txt 
for i in {110..124}; do time=$(cat result/cartf_fs_5004_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt 
echo -e '\n Recepcao server FS - App_E2 - apos processamento:' >> relatorio.txt
for i in {110..124}; do time=$(cat result/server_e2tf_car_fs_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt

echo -e '\n Transmissao veiculos FN - App_G - apos processamento:' >> relatorio.txt 
for i in {110..124}; do time=$(cat result/cartf_fn_5005_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt 
echo -e '\n Recepcao server FN - App_G - apos processamento:' >> relatorio.txt
for i in {110..124}; do time=$(cat result/server_gtf_car_fn_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt

echo -e '\n Transmissao veiculos FQ - App_G - apos processamento:' >> relatorio.txt 
for i in {110..124}; do time=$(cat result/cartf_fq_5005_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt 
echo -e '\n Recepcao server FQ - App_G - apos processamento:' >> relatorio.txt
for i in {110..124}; do time=$(cat result/server_gtf_car_fq_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt

echo -e '\n Transmissao veiculos FS - App_G - apos processamento:' >> relatorio.txt 
for i in {110..124}; do time=$(cat result/cartf_fs_5005_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt 
echo -e '\n Recepcao server FS - App_G - apos processamento:' >> relatorio.txt
for i in {110..124}; do time=$(cat result/server_gtf_car_fs_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt

echo -e '\n Transmissao veiculos FN - App_S - apos processamento:' >> relatorio.txt 
for i in {110..124}; do time=$(cat result/cartf_fn_5002_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt 
echo -e '\n Recepcao server FN - App_S - apos processamento:' >> relatorio.txt
for i in {110..124}; do time=$(cat result/server_stf_car_fn_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt

echo -e '\n Transmissao veiculos FQ - App_S - apos processamento:' >> relatorio.txt 
for i in {110..124}; do time=$(cat result/cartf_fq_5002_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt 
echo -e '\n Recepcao server FQ - App_S - apos processamento:' >> relatorio.txt
for i in {110..124}; do time=$(cat result/server_stf_car_fq_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt

echo -e '\n Transmissao veiculos FS - App_S - apos processamento:' >> relatorio.txt 
for i in {110..124}; do time=$(cat result/cartf_fs_5002_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt 
echo -e '\n Recepcao server FS - App_S - apos processamento:' >> relatorio.txt
for i in {110..124}; do time=$(cat result/server_stf_car_fs_tt.txt | grep 200.0.10.$i | head -1 | cut -d' ' -f1); car=$(echo $i -110 | bc) ; echo car$car $time; done >> relatorio.txt

