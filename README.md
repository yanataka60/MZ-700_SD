# MZ-700バンク切替対応MZ-80K_SD基板

![MZ-700_SD](https://github.com/yanataka60/MZ-700_SD/blob/main/JPEG/MZ-700_SD_1.JPG)

　MZ-80K_SDはROMをF000Hに置くことでFDコマンドを利用してフロッピーディスク装置の代わりにSD-CARDを繋いでしまおうというものですが、MZ-700でバンク切替によりオールRAMとなったときに、MZ-80K_SDのROMがEnableのままなのでMZ-700本体のRAMと両方有効になってしまっています。

　実際にS-BASIC等動かしてみるとそのまま問題なく動いているようにも見えるのですが、バンクが切り替わったときにはROMがDisableになったほうが安心です。

　MZ-80K_SDのページではスイッチでROMを切り離す方法を紹介しています。
https://github.com/yanataka60/MZ80K_SD?tab=readme-ov-file#rom%E5%88%87%E3%82%8A%E9%9B%A2%E3%81%97%E3%82%B9%E3%82%A4%E3%83%83%E3%83%81%E6%94%B9%E9%80%A0

#### 2024.10.10 MZ-80K_SD基板をRev1.5.5とし、ROMを切り離しスイッチを標準装備としました。

　MZ-700_SDではバンクが切り替わったときにGAL16V8を使ってROMのDisable、Enableが自動で切り替わります。

#### 試作から2か月経過しましたが、特に問題が発生していないので正式公開とします。

~~####  ただし、MZ-80K_SD開発時に使っていたGAL22V10がMZ-80K本体と相性が悪いのかどうにも動作が不安定で泣く泣く汎用ロジックICに置き換えた経験からGALを使っても動作が安定していると確信できるまではテスト公開とします。~~

####  また、入手性も汎用ロジックICに比べてGAL16V8は良くないです。

　なお、GAL16V8、Arduino、ROMへ書き込むための機器が別途必要となります。

## 回路図
　KiCadフォルダ内のMZ-700_SD.pdf参照

[回路図](https://github.com/yanataka60/MZ-700_SD/blob/main/KiCad/MZ700_SD.pdf)
![回路図](https://github.com/yanataka60/MZ-700_SD/blob/main/KiCad/MZ700_SD_1.jpg)

## 部品
　U7 GAL16V8 1個が追加された以外はMZ-80K_SD Rev1.5.3と同様です。

　MZ-80K_SD Rev1.5.5との違いはRev1.5.5でのS3スイッチと10kΩの抵抗の代わりにGAL16V8が必要となります。

　私はGAL16V8Dを使っています。

|番号|品名|数量|備考|
| ------------ | ------------ | ------------ | ------------ |
|U1|74LS04|1||
|U2|2764又は28C64|1|ROMの相性については後述|
|U3|8255|1||
|U4|Arduino_Pro_Mini_5V|1|Atmega328版を使用 168版は不可。(注1)|
|U5 U6|74LS30|2||
|U7|GAL16V8|1||
||J2、J5のいづれか|||
|J2|Micro SD Card Kit又は同等品|1|秋月電子通商 AE-microSD-LLCNV (注2) (注3)|
|J5|MicroSD Card Adapter|1|Arduino等に使われる5V電源に対応したもの (注3)|
|C1-C5,C7|積層セラミックコンデンサ 0.1uF|6||
|C6|電解コンデンサ 16v100uF|1||
|S1 S2|3Pスライドスイッチ|2|秋月電子通商 SS12D01G4など|
|J4|DCジャック|1||
|J3|コネクタ 2Pin|1|ピンヘッダで代用するときはGNDと間違えないよう1Pinで5Vだけにしたほうが良い|
|J1|50Pinコネクタ|1||
||50Pinケーブル|1||
||ピンヘッダ|2Pin分|Arduino_Pro_MiniにはA4、A5用のピンヘッダが付いていないため別途調達が必要です 秋月電子通商 PH-1x40SGなど|
||本体内から5Vを取る場合、ケーブル少々|||
||本体ROMにパッチをあてる場合、27C32等を2532ソケットに差すためのアダプタ|||
||ピンソケット(任意)|26Pin分|Arduino_Pro_Miniを取り外し可能としたい場合に調達します 秋月電子通商 FHU-1x42SGなど|

　　　注1)Arduino Pro MiniはA4、A5ピンも使っています。

　　　注2)秋月電子通商　AE-microSD-LLCNVのJ1ジャンパはショートしてください。

　　　注3)J2又はJ5のどちらかを選択して取り付けてください。

### MicroSD Card Adapterを使う(Rev1.5.3以降)
J5に取り付けます。

MicroSD Card Adapterについているピンヘッダを除去してハンダ付けするのが一番確実ですが、J5の穴にMicroSD Card Adapterをぴったりと押しつけ、裏から多めにハンダを流し込むことでハンダ付けをする方法もあります。なお、この方法の時にはしっかりハンダ付けが出来たかテスターで導通を確認しておいた方が安心です。

ハンダ付けに自信のない方はJ2の秋月電子通商　AE-microSD-LLCNVをお使いください。AE-microSD-LLCNVならパワーLED、アクセスLEDが付いています。

![MicroSD Card Adapter1](https://github.com/yanataka60/MZ80K_SD/blob/main/JPEG/MicroSD%20Card%20Adapter(1).JPG)

![MicroSD Card Adapter2](https://github.com/yanataka60/MZ80K_SD/blob/main/JPEG/MicroSD%20Card%20Adapter(2).JPG)

![MicroSD Card Adapter3](https://github.com/yanataka60/MZ80K_SD/blob/main/JPEG/MicroSD%20Card%20Adapter(3).JPG)

![MicroSD Card Adapter4](https://github.com/yanataka60/MZ80K_SD/blob/main/JPEG/MicroSD%20Card%20Adapter(4).JPG)

## GAL16V8プログラム
　Wincuplフォルダ内のMZ700_ROM.jedをROMライター(TL866II Plus等)を使ってGAL16V8に書き込んでください。

## ROMプログラムについて、Arduinoプログラム等
　以下、MZ-80K_SD Rev1.5.5と同様ですのでMZ-80K_SDプロジェクトを参照してください。。

https://github.com/yanataka60/MZ80K_SD?tab=readme-ov-file#rom%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%A0%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6

## テストプログラム
　RAMへの書込みが正常に行われ、読み出す時にはROMのデータと混じらずに書き込んだデータと同じ値が正常に読み出せること、またROMを読み出してもデータが不変であることを確認するためにテストプログラムを作成しました。

　Z80フォルダTESTフォルダ内のTEST-MZ700.MZTを実行するとROMを読出して比較、RAMに書込み、読出して比較をバンク切替しながらF000hからFFFFhまでのメモリアドレスを順次検査していき、RAMの読出し比較がエラーとなればそこで止まります。

　私の環境でバンク切替対応基板が正常に終了することは確認済みですが、困ったことに未対策のMZ-80K_SD Rev1.5.3基板でも正常に終了してしまいました。

　MZ-80Kではスタートと同時にエラーで止まりますのでテストプログラムは正常なはずです。

　ROMとRAMのアクセスタイムが関係しているのかもしれませんが、バンク切替対応基板だとここが直りますというところが明確ではないです。

　なお、ロジックアナライザを使い、バンク切替対応基板ではOUT (E1h),AでGAL16V8 Pin17(LATCH)がDisableとなり、OUT (E3h),A、OUT (E4h),AでGAL16V8 Pin17(LATCH)がEnableとなり正常に動作することは確認しています。

　　未対策のMZ-80K_SD Rev1.5.3基板ではOUT (E1h),A、OUT (E3h),A、OUT (E4h),Aいずれの状態でもF000h～FFFFhアクセス時にROMCEはEnableのままです。

## 謝辞
　基板の作成に当たり以下のデータを使わせていただきました。ありがとうございました。

　Arduino Pro Mini

　　https://github.com/g200kg/kicad-lib-arduino

　AE-microSD-LLCNV

　　https://github.com/kuninet/PC-8001-SD-8kRAM

## 追記
2024.10.10

　正式公開
