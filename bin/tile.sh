#!/usr/bin/env bash
set -ex

LOG_ERR=../err_log/`date +%Y-%m-%d_%H-%M-%S.log`


function makeTile(){

    cd ~/Desktop/CreateTile/excel_data

    # excelファイルのみ取得し、csvに変換
    ls *.xlsx | while read line
    do
        filename=`basename $line .xlsx`
        csv=$filename".csv"
        xlsx2csv $line $csv
        mv $csv ../csv_data
    done

    cd ../csv_data

    # csvファイルのみ取得し、geojsonに変換
    ls *.csv | while read line
    do
        echo $line
        sed -i '' "s/緯度/lat/" $line
        sed -i '' "s/経度/lon/" $line
        filename=`basename $line .csv`
        geojson=$filename".geojson"
        ogr2ogr -f GeoJSON $geojson $line -oo X_POSSIBLE_NAMES=lat* -oo Y_POSSIBLE_NAMES=lon*
        if [ ! -e ../geojson_data ]; then mkdir ../geojson_data ; fi
        mv $geojson ../geojson_data
    done

    cd ../geojson_data

    # geojsonファイルのみ取得し、pmtilesに変換
    ls *.geojson | while read line
    do
        filename=`basename $line .geojson`
        tile=$filename".pmtiles"
        tippecanoe -o $tile $line
        if [ ! -e ../tile_data ]; then mkdir ../tile_data ; fi
        mv $tile ../tile_data
        echo $tile
    done

    # TODO：errorログの出力
    # if [[ $2 != "" ]]; then
    #    echo -e "$2" | tee -a $LOG_ERR
    # fi

    # TODO:wihleを関数化

}

makeTile