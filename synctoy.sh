#!/bin/bash
# preciso corrigir erro que copia o diretorio de origem junto
script=$0
qtd_arg=$#
if [[ $qtd_arg -ne 2 ]]; then
	echo  "Uso $script <diretório_origem> <diretório_destino>"
else
	if [ -d $1 ]; then
		echo "Sincronizacao iniciada"
                if [ -d $2 ]; then
			arquivo=($(ls $1 -1))
                        for  arq in "${arquivo[@]}"
                        do
                        if [ -d $1/$arq ]; then
                                if [[ -e $2/$arq ]]; then
                                        if [[ $1/$arq -nt $2/$arq ]];then
                                                echo "Atualizando diretório $arq"
                                                cp -r $1/$arq $2/$arq
                                        else
                                                echo "Ignorando diretorio $arq"
                                        fi
                                else
                                        echo "Criando diretorio $arq"
                                        cp -r $1/$arq $2/$arq
                                fi
                        else
                                if [[ -e $2/$aqr ]]; then
                                        if [[ $1/$arq -nt $2/$arq ]]; then
                                                echo "Atualizando arquivo $arq"
                                                cp $1/$arq $2/$arq
                                        else
                                                echo "Ignorando arquivo $arq"
                                        fi
                                else
                                        echo "Criando arquivo $arq"
                                        cp $1/$arq $2/$arq
                                fi
                        fi
                        done
		fi
		while [ ! -d $2 ]; do
			echo "Aguardando conexao com destino: $2"
			for num in {9..0}
			do
			echo -n "*"
			sleep 1
			done
			echo ""
		done
		echo "Sincronizacao encerrada"
	else
		echo "Diretorio de origem nao encontrado: $1"
		echo "Encerrando execucao"
	fi
fi

exit 0
