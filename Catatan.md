Catatan Singkat



* Asumsi yang diambil dan alasan: dalam validasi koordinat diberikan instruksi untuk memperbaiki terlebih dahulu koordinat kemudian menampikan data yang bermasalah, namun saya hal tersebut menurut saya terbalik dikarenakan jika memperbaiki terlebih dahulu maka status swaped akan tidak ada, sehingga dalam membuat table data yang bermasalah maka data yang sudah diperbaiki atau status sebelumnya swaped tidak akan tertampil karena sudah diperbaiki begitupun jika dibalik. maka saya mengambil asumsi untuk data yang telah perbaikan data itu akan disimpan ditabel baru sehingga nanti jika ingin menampilkan data yang bermasalah untuk evaluasi dan lain lain tinggal memanggil data yang belum diperbaiki. jadi data yang diperbaiki tetap ada, data historis yang belum diperbaiki dan apabila ingin ditampilkan tetap ada juga. 
* Data yang beresiko dan perlu ditanyakan: menurut saya data yang beresiko adalah adalah koordinat dikarenakan terdapat tahapan memvalidasi dan memperbaiki, untuk kasus data swapped bisa saja langsung ditukar, namun untuk data out of range bisa saja data tersebut hanya typo, sehingga perlu ditanayakan Kembali ke pemiliki data. Karena data tersebut juga perlu ditindak lanjuti. maka dari itu menurut saya historis menjadi penting untuk disimpan.
* Jika saya ada Waktu lebih saya dapat menambahkan validasi seperti apakah benar benar titik tersbeut berapa diwilayah kecamatan yang benar dengan menambahkan menambahkan bonding box beupa administrasi kecamatan dengan algroitma:
* semisal data  titik kecamatan dengan id 3333 maka data tersebut harus berada dalam bonding box data administrasi kecamatan dengan id 3333
* Penggunaaan AI terdapat pada penulisan source code/script

