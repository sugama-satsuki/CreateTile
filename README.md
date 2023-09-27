# CreateTile
excelファイル、csvファイル、geojsonファイルからpmtilesを作成します。

## 使い方
``` shell
cd ~/Desktop
git clone https://github.com/sugama-satsuki/CreateTile.git
```
テストデータとして、excelファイルcsvファイルを置いています。

```
excel_data
	└ 12_suisyou_koukyoushisetu-1.xlsx

csv_data
	└ 470007_hospital.csv
	└ 473022_evacuation_space.csv
```

---
① pmtilesファイルに変換したいexcelファイルを `excel_data` フォルダへ格納

　 ※ データがcsvファイルの場合は `csv_data` へ、geojsonの場合は`gojson_data`へ



② ターミナルにて、下記を実行。
```shell
# bash使用の場合
bash ~/クローン先のパス/tile/bin/tile.sh
```
