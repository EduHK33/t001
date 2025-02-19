#!/bin/bash
echo -e "\033[1;34m TraceHunter-Forencic Collector\033[0m"
#Passo 1
if [[ $EUID -ne 0 ]]; then
echo -e "\033[1;31m Este script pode ser executado apenas como root.\033[0m"
exit 1
fi

#Passo 2
COLLECTED_DIR="collected_files"
mkdir -p "$COLLECTED_DIR"

#Passo 3
echo -e "\033[1;35m Coletando arquivos do sistema...\033[0m"

#Passo 4
echo -e "\033[0;95m Listando informações sobre discos e partições...\033[0m"
lsblk > $COLLECTED_DIR/disk_info.txt

#Passo 5
echo -e "\033[0;95m Coletando informações de rede...\033[0m"
ss > $COLLECTED_DIR/active_connections.txt
netstat > $COLLECTED_DIR/open_ports.txt

#Passo 6
echo -e "\033[0;95m Coletando lista de processos...\033[0m"
ps aux > $COLLECTED_DIR/process_list.txt

#Passo 7
echo -e "\033[0;95m Coletando logs do sistema...\033[0m"
cp /var/log/syslog $COLLECTED_DIR/syslog.log
cp /var/log/auth.log $COLLECTED_DIR/auth.log
cp /var/log/dmesg $COLLECTED_DIR/dmesg.log

#Paaso 8
echo -e "\033[0;95m Coletando arquivos de configuração...\033[0m"
cp -r /etc $COLLECTED_DIR/config_files.txt

#Passo 9
echo -e "\033[0;95m Listando o diretório raiz...\033[0m"
ls -la / > $COLLECTED_DIR/root_dir_list.txt

#Passo 10
tar -czf "TraceHunter_$(hostname)_$(date +%Y%m%d_%H%M%S).tar.gz" $COLLECTED_DIR
