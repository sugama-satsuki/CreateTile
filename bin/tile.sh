#!/usr/bin/env bash
set -ex

LOG_ERR=../err_log/`date +%Y-%m-%d_%H-%M-%S.log`

# execlファイルからcsvファイルを生成
function excelToCsv() {
    filename=$(basename $1 .xlsx)
    csv=$filename".csv"
    xlsx2csv $1 $csv
}

# csvファイルからgeojsonファイルを生成
function csvToGeojson() {
    filename=$(basename $1 .csv)
    echo "-----"$filename"-----"
    geojson=$filename".geojson"
    sed -i '' "s/緯度/lat/" $1
    sed -i '' "s/経度/lon/" $1

    ogr2ogr -f GeoJSON $geojson $1 -oo X_POSSIBLE_NAMES=lat* -oo Y_POSSIBLE_NAMES=lon*
    if [ ! -e ../geojson_data ]; then mkdir ../geojson_data ; fi
}

# geojsonファイルからpmtilesを生成
function geojsonToTile() {
    filename=$(basename $1 .geojson)
    tile=$filename".pmtiles"
    tippecanoe -o $tile $1
    if [ ! -e ../tile_data ]; then mkdir ../tile_data ; fi
}


# タイルの生成
function makeTile(){

    cd ~/Desktop/CreateTile/data

    ls | while read line
    do
        extension="."${line##*.}
        filename=$(basename $line $extension)

        case $extension in
            ".xlsx") echo "1"$line
                    excelToCsv $line
                    csvToGeojson $filename".csv"
                    break;;
            ".csv") echo $line
                    csvToGeojson $line
                    break;;
            ".geojson") ;;
        esac
    done


    # TODO：errorログの出力
    # if [[ $2 != "" ]]; then
    #    echo -e "$2" | tee -a $LOG_ERR
    # fi

}

makeTile