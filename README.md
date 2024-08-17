# MZ-700バンク切替対応MZ-80K_SD基板(テスト中)

![MZ-700_SD](https://github.com/yanataka60/MZ-700_SD/blob/main/JPEG/MZ-700_SD_1.JPG)

　MZ-80K_SDはROMをF000Hに置くことでFDコマンドを利用してフロッピーディスク装置の代わりにSD-CARDを繋いでしまおうというものですが、MZ-700でバンク切替によりオールRAMとなったときに、MZ-80K_SDのROMがEnableのままなのでRAMと両方有効になってしまっています。

　実際にS-BASIC等動かしてみるとそのまま問題なく動いているようにも見えるのですが、バンクが切り替わったときにはROMがDisableになったほうが安心です。

　MZ-80K_SDのページではスイッチでROMを切り離す方法を紹介しています。
https://github.com/yanataka60/MZ80K_SD?tab=readme-ov-file#rom%E5%88%87%E3%82%8A%E9%9B%A2%E3%81%97%E3%82%B9%E3%82%A4%E3%83%83%E3%83%81%E6%94%B9%E9%80%A0

　こちらではバンクが切り替わったときにGAL16V8を使ってROMのDisable、Enableが自動で切り替わります。

####  ただし、MZ-80K_SD開発時に使っていたGAL22V10がMZ-80K本体と相性が悪いのかどうにも動作が不安定で泣く泣く汎用ロジックICに置き換えた経験からGALを使っても動作が安定していると確信できるまではテスト公開とします。

####  また、入手性も汎用ロジックICに比べてGAL16V8は良くないです。

　なお、GAL16V8、Arduino、ROMへ書き込むための機器が別途必要となります。

## 回路図
　KiCadフォルダ内のMZ-700_SD.pdf参照

[回路図](https://github.com/yanataka60/MZ-700_SD/blob/main/KiCad/MZ700_SD.pdf)
![回路図](https://github.com/yanataka60/MZ-700_SD/blob/main/KiCad/MZ700_SD_1.jpg)

## 部品
　U7 GAL16V8 1個が追加された以外はMZ-80K_SD Rev1.5.3と同様です。

　私はGAL16V8Dを使っています。

https://github.com/yanataka60/MZ80K_SD?tab=readme-ov-file#%E9%83%A8%E5%93%81

## GAL16V8プログラム
　Wincuplフォルダ内のMZ700_ROM.jedをROMライター(TL866II Plus等)を使ってGAL16V8に書き込んでください。

## ROMプログラムについて、Arduinoプログラム等
　以下、MZ-80K_SD Rev1.5.3と同様ですのでMZ-80K_SDプロジェクトを参照してください。。

https://github.com/yanataka60/MZ80K_SD?tab=readme-ov-file#rom%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%A0%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6

## テストプログラム
　RAMへの書込みが正常に行われ、読み出す時にはROMのデータと混じらずに書き込んだデータと同じ値が正常に読み出せること、またROMを読み出してもデータが不変であることを確認するためにテストプログラムを作成しました。

　Z80フォルダTESTフォルダ内のTEST-MZ700.MZTを実行するとROMを読出して比較、RAMに書込み、読出して比較をバンク切替しながらF000hからFFFFhまでのメモリアドレスを順次検査していき、RAMの読出し比較がエラーとなればそこで止まり、最後まで正常であればFFFFhの次に0000hを検査したときにRAMの読出し比較がエラーとなり止まります。

　私の環境でバンク切替対応基板が正常に終了することは確認済みですが、困ったことに未対策のMZ-80K_SD Rev1.5.3基板でも正常に終了してしまいました。

　0000hでエラーとなって止まること、MZ-80Kではスタートと同時にエラーで止まりますのでテストプログラムは正常だと思います。

　ROMとRAMのアクセスタイムが関係しているのかもしれませんが、バンク切替対応基板の優位性が明確にはなっていません。

　なお、ロジックアナライザを使い、バンク切替対応基板ではOUT (E1h),AでGAL16V8 Pin17(LATCH)がDisableとなり、OUT (E3h),A、OUT (E4h),AでGAL16V8 Pin17(LATCH)がEnableとなり正常に動作することは確認しています。

　　未対策のMZ-80K_SD Rev1.5.3基板ではOUT (E1h),A、OUT (E3h),A、OUT (E4h),Aいずれの状態でもF000h～FFFFhアクセス時にROMCEはEnableのままです。

## 謝辞
　基板の作成に当たり以下のデータを使わせていただきました。ありがとうございました。

　Arduino Pro Mini

　　https://github.com/g200kg/kicad-lib-arduino

　AE-microSD-LLCNV

　　https://github.com/kuninet/PC-8001-SD-8kRAM

