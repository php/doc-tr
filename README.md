# PHP Belgeleri NASIL çevrilir?

Çeviriye katkıda bulunmanız 3 şekilde mümkündür:
* PHP karmanız vardır,
* PR yapabilirsiniz,
* Çevirilerinizi ekip liderine gönderirsiniz.

Hangi yöntemi kulanırsanız kullanın, çevirmenlerimizin birçok dilde ama
mutlaka PHP ile kodlama yapabildiğini, komut satırından git kullanabildiğini,
GitHub kullanabildiğini, HTML ve XML belgeler üretmekte ve düzenlemekte zorluk
çekmeyeceğini, iyi ingilizce ve türkçe bildiğini ama en önemlisi "öğrenmeyi"
bildiğini (herşeyi bilemeyiz ama öğrenebiliriz) varsayıyoruz. Aşağıdaki
bilgiler Linux kullananlara göre düzenlenmiştir.

Bir GitHub hesabınız olması önerilir.
Örnek: https://github.com/nilgun

PR yapacaksanız GitHub hesabınızda oturum açtıktan sonra
https://github.com/php/doc-tr adresine gidip bu depoya bir "fork" açın.
Hesap sayfanızda yeni bir deponuz oldu. PR yapmayanlardan farklı olarak
`tr` deposu olarak bu depoyu kullanacaksınız.

Bizim çalışacağımız modülün ismi: `tr`

Önce çalışma dizininizi oluşturun: `phpdoc`
Dizine geçin ve şu komutları girin:

GitHub PR'ları yapacaklar için komutlar:
```bash
git clone git@github.com:<github-user>/doc-tr.git tr
git clone https://github.com/php/doc-en.git en
git clone https://github.com/php/doc-base.git doc-base
```
Liderle çalışacaklar için komutlar:
```bash
git clone https://github.com/php/doc-tr.git tr
git clone https://github.com/php/doc-en.git en
git clone https://github.com/php/doc-base.git doc-base
```

PHP karması olanların https://github.com/php/doc-base/README.md dosyasını
okuduktan sonra buraya dönmesini öneririm.

Bu komutlar `doc-base`, `en` ve `tr` diye üç dizin açacak ve altına GiT
deposundan bu modüllere ait dosyaları indirecektir. Bundan sonra `phpdoc/tr`
dizininden bahsederken "çalışma dizini" diyeceğiz. Bunu yaptıktan sonra yeni
bir çeviriye başlamaya karar vermeden önce bu üç dizinde de daima

```bash
git pull
```

komutunu vermelisiniz. Bu komut çalışma dizininizi son haline getirir.
`tr` dizininde sadece çevrilmiş ve çevirisi sürmekte olan dosyalar vardır.
Yani çevireceğiniz dosya `tr` altında varsa başka bir dosya seçmeniz gerekecek.
Çevireceğiniz dosyayı `en` dizini altından seçip `tr` altındaki yerine
kopyalayacaksınız. Örneğin, `en/reference/apache/book.xml` dosyasını
gözünüze kestirdiniz diyelim. Yapacağınız, çalışma dizininizin içinde
```bash
cp en/reference/apache/book.xml tr/reference/apache/book.xml
```
komutunu vermeye eşdeğer bir işlem olacak.

GiT deposuyla çalışmak için Linux altında `git-gui` ve `gitk` kullanılabilir.
`tr` altında komut satırından `gitk` komutunu verin. `gitk` arayüzünden
`git-gui` uygulamasını çalıştırmak için bir seçenek mevcut.
Windows için de benzer arayüz kullanılabiliyor: https://gitforwindows.org/

Ama hemen çeviriye girişmeyeceksiniz. Bazı önişlemler var.

Dosyanın ilk satırı genelde şuna benzer bir girdi içerir:
```
<?xml version="1.0" encoding="utf-8"?>
```
Bu satıra "XML başlığı" diyelim.

Burada "utf-8", çeviri yaparken kullanacağınız karakter kodlamasıdır.

XML başlığının altına şöyle bir satır ekleyin:
```
<!-- EN-Revision: 123456 Maintainer: flarecaster Status: ready -->
```
Bu satıra "güncelleme satırı" diyelim.
`123456` özgün belgenin "commit hash"i olup aslında oldukça uzun bir dizedir,
`flarecaster` çevirmenin translation.xml dosyasında yazan kullanıcı adı (nick),
sonuncusu ise dosyanın durumunu gösterecek. Çeviriye başlarken oraya`wip`,
tamamlandığında `ready` yazacaksınız.

Böylece özgün belgenin sürüm numarası değiştiğinde `en` dizini altındaki
dosya için
```bash
git diff <EN-revision> <en/dizin/dosya>
```
komutuyla eski ve yeni sürümler arasındaki farkı kolayca görebilecek,
tüm dosyayı yeni baştan çevirircesine elden geçirmekten kurtulacağız.
Yani, çeviriyi güncellemek kolaylaşacak. Tabii, çeviriyi yapan
güncelleyecek ;-)

Güncelleme sırasında `123456` yerine özgün belgenin yeni commit hash'ini
yazmayı unutmuyoruz. Bunu elde etmek için özgün belgenin bulunduğu dizinde
şu komutu verin:
```
cmhash  <dosya.xml>
```

Bu başta çalışmayacak çünkü `cmhash` bir bash alias.
Ev dizinizde `.bashrc` dosyasının sonuna şu satırı ekleyin:
```bash
alias cmhash='git log -n1 --format=format:"%H"'
```
ve aynı satırı bir defalık komut satırından da girin ki oturum aç/kapa
yapmak gerekmesin. Böylece her dosya için bu alengirli komutu yazmaktan
kurtulursunuz.

Güncelleme satırının altında bazı dosyalarda
```
<!-- CREDITS: cumhuronat, tpug, antimon, flarecaster -->
```
gibi satırlar göreceksiniz. Bu kişiler o belgenin çevirisiyle evvelce
ilgilenmiş kişilerdir. Onları böyle bir satırla hatırlamış oluyoruz.

Sıra geldi çeviride dikkat edilecek hususlara...
XML dosyalarla çalışırken dosyanın sekme karakterini (09) içermemesi gerekir.
Eğer metin düzenleyiciniz yapabiliyorsa sekmeleri boşluklara çevirmeyi etkin
kılın, yapamıyorsa bunu yapabilen bir metin düzenleyici bulun. Bulamıyorsanız,
sekme yerine boşluk tuşuna basın. Zaten çalışacağınız XML dosyaların
girintileri 1 karakter uzunlukta.

78 sütundan daha geniş satırlar kullanmayın. Uzun satırlar farkları (`diff`)
komut satırından görmek istediğinizde işinizi kolaylaştırmayacaktır.

Dosyalar `<para>This extension requires PHP 8.</para>` şeklinde HTML'ye benzer
etiketler arasında bir takım metinler içerir. Bu etiketler XML belgenin yapı
taşları olduğundan onları çevirmeyeceğiz. Bazı etiketlerin HTML
etiketlerindeki gibi öznitelikleri vardır, onlara da dokunmuyoruz. Yani,
yukarıdaki metni `<para>Bu eklenti PHP 8 gerektirir.</para>`
şeklinde çevireceğiz.

Ayrıca dosyalarda bazen `&` ile başlayıp `;` ile biten bazı sözcüklere
rastlayacaksınız. Onları cümlenin bir parçası haline getireceksiniz.
Örneğin,
```
<para>You must enable the <literal>foo</literal> setting in &php.ini;</para>
```
yerine
```
<para><literal>foo</literal> ayarını &php.ini; içinde yapmış olmalısınız.</para>
```
yazacaksınız. Ancak bazı durumlarda bunu yapamayabiliriz. Değişken içindeki
metin parçası cümle içinde kulanıldığında bir yerde doğruyken başka bir
yerde imla hatasına yol açabilir. Böyle bir durumdan şüphe duyarsanız mevcut
HTML belgeye bakıp ne yapacağınıza kendiniz karar vermelisiniz. XML belgeyle
ilişkili HTML belgelere, genellikle, XML belgenin kök etiketindeki `xml:id`
değerinin sonuna `.html` veya `.php` getirerek ulaşabilirsiniz.

Tırnak karakteri yerine `&apos;` kullanılmışsa siz de onu kullanın.
Sizin cümle içinde tek tırnak imi kullanmanız gerekirse zor gelmeyecekse
yine `&apos;` kullanın. Böylece farklı tırnak imleri yerine tek bir tırnak
imi kullanmış oluruz. Ayrıca XML belgelerin HTML veya PHP'ye dönüştürülmesi
sırasında olası bir tırnak ayırma hatasını da önlemiş oluruz. Bu durum
belgelerin kılavuz sayfaları üretilirken bilhassa önem kazanmaktadır.
Kılavuz (man) sayfalarında `'` iminden başkası (`&apos;` olur, kendileri)
görüntülenmez. Yani `&apos;` yerine başka bir tırnak imi kullanmışsanız kılavuz
sayfasında o tırnağı bulamayabilirsiniz.

Çeviri bittikten sonra güncelleme satırındaki `wip` dizgesini
`ready` yapmayı unutmayın.

Linux kullananların çeviriyi kate üzerinde yapmasını öneririm.
Windows kullananlara notepad++ öneririm.

Son olarak dosyayı teslim etmeden önce
`phpdoc/doc-base` dizininde şu komutunu kullanın:
```bash
$ php configure.php --with-lang=tr --enable-force-dom-save --disable-segfault-error --enable-xml-details
```
Komut hata vermemişse ve bir GiT hesabınız varsa veya GitHub PR'ı
yapacaksanız dosyayı depoya gönderebilirsiniz.
Aksi takdirde, dosyayı ekip liderine göndermelisiniz.
Verdiği hatayı nasıl gidereceğinizi bilmiyorsanız listedekilere sorunuz.
(Burada artık esr'nin ünlü belgesinden söz etmeyelim.) Hatalı dosyayı bana
gönderebilirsiniz ama ASLA ve ASLA depoya teslim etmeyin.

Git hesabı olanlar için teslimat işlemleri:
```bash
git commit -m"açıklamayı buraya yazın" <dosya.xml>
git push
```
PR yapacak olanlar bu işlemden sonra artık GitHub hesaplarında
Pull Request oluşturabilir.

Çeviri projesinin son durumunu öğrenmek için `phpdoc` dizini altında
aşağıdaki komutu verin ve `revcheck.html` dosyasını tarayıcınız ile açın.
Çevirmenler için çok yararlı bir araçtır.
```bash
php doc-base/scripts/revcheck.php tr > revcheck.html
```
Veya http://doc.php.net/revcheck.php?p=filesummary&lang=tr adresine bakın
(4 saatte bir güncellenmektedir).


### Sözlük

Aşağıda İngilizce terimlerin bu çeviride kullandığımız Türkçe karşılıkları
yazılmıştır. _AMACIMIZ AYNI TERİMLERİ KULLANMAK, OKUYUCUYU FARKLI TERİMLERLE
KAVRAM KARGAŞASI İÇİNDE BIRAKMAMAKTIR._

```
_               Altçizgi imi
&               Ve imi
Abstract        Metin için "Özet" ifadeler için "soyut" veya "mutlak"
Argument        Değiştirge
Array           Dizi
Associative Array  İlişkisel Dizi
Attribute       Öznitelik
Authentication  Kimlik doğrulama
Authorization   Yetkilendirme
Backslash       Ters bölü
Binary          Uygulamaysa kastedilen "çalıştırılabilir", kendisi bir veri
                türü ise çevrilmez, veri türünü niteliyorsa "ikil", bir
                işleci niteliyorsa "iki terimli".
Bitwise         Bitsel
Boolean         Mantıksal
Built-in        Yerleşik
Callback        Geriçağırım
Class           Sınıf
Closure         Kapsanım
Unicode Code Point    Unicode Karakter Kodu
Compile         Derleme
Configuration   Yapılandırma
Constants       Sabitler (Değişmezler değil!)
Contravariance  Az Özgüllük (bu ikisi tam karşılık değil, kullanıma uygunluk sağlar)
Covariance      Çok Özgüllük
Control Structure    Denetim Yapısı
Default         Öntanımlı
Detail          Ayrıntı (lütfen "detay" diye çevirmeyin)
Digest          Özet
Directive       Yönerge
double quote    çift tırnak "
Endian          Dip
Escape          Escape tuşu için çevrilmez.
Escape character  Önceleme karakteri
Exception       İstisna
Executable      Çalıştırılabilir
Extention       Eklenti
Extents         Genişletir (nyp)
Float           Gerçek sayı, kayan noktalı sayı
Form            Form
Function        İşlev
Handle          Tanıtıcı
Handler         İşleyici
Hash            Aş
Hashing         Aşlama
Heredoc         Yorumlu metin
Idle            Boşakoşum
Implementation  Gerçeklenim
Implements      Gerçekler (nyp)
Include         dahil etme
Index           (diziler için) indis
Initialize      İlklendirmek
Instantiate     Örnekleme
Interpreter     Yorumlayıcı
integer         tamsayı
Label           Yafta
Matrix          Dizey
Method          Yöntem
mixed           karışık
Module          Modül
Multithread     Çok evreli
Multibyte       Çok baytlı
Nowdoc          Yorumsuz metin
Nullable        Boş olabilen
Object          Nesne
Operand         Terim
Operator        İşleç
Original        Özgün
Outputs         Çıktılanır
Override        Geçersiz kılmak
Parameter       Değiştirge
Parse error     Çözümleme hatası
Parser          Çözümleyici
Pass into       İçe aktarmak
Peer            Görevdeş
Pointer         Fare oku sözkonusu ise "imleç", C tarzı ise "gösterici"
Predefined      Önceden tanımlanmış
Procedure       Yordam
Protocol        Protokol
Ouery string    Sorgu dizesi
Reference       gönderim, başvuru
Regular expression	Düzenli ifade
Resource        Özkaynak
root user       root kullanıcı (Linux'ta en yetkili kullanıcı root'dur).
Runtime         Çalışma anı
Scalar          Sayıl, değişmez
Scope           Etki Alanı
Script          Betik
Scripting       Kodlama, kod yazma
Serialize       Dizeleştirme
Server          Sunucu
single quote    tek tırnak '
Slash           Bölü imi
Statement       Deyim
Strict Typing   Katı Kodlama
String          Dize, dizge
Tag             İmlenim dilleri (*ML) için "etiket"
Ternary         Üç terimli
Thread          Evre
Throws          Yavrulanır (nyp)
Trait           Nitelik
Transaction     Veri hareketi
Type            "Tür" veya "veri türü"
Unary           Tek terimli
Union type      Birleşim türü
Unpack          Genişletme, yayma
Unserialize     Nesneleştirme
Validation      Geçerlilik
Variable        Değişken
Variance        Farklılık
Vector          Yöney
Web Server      HTTP Sunucusu
Widget          Gereç
Version.Revision.Patch   Biz bunun tamamına ve parçalarına sürüm numarası
                diyoruz. Bu kılavuzun okuyucusu için sürüm numarasını oluşturan
                parçaların isimlerinin bir önemi olmayacaktır.
```

PHP Belgelelerinin yapısı ve daha pek çok şey hakkında fikir edinmek için
http://doc.php.net/tutorial/ adresindeki belgeyi ve
git hakkında kapsamlı bilgi edinmek için http://git-scm.com/book adresindeki
belgeyi okuyun.

