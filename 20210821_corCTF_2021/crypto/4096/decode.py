n = 50630448182626893495464810670525602771527685838257974610483435332349728792396826591558947027657819590790590829841808151825744184405725893984330719835572507419517069974612006826542638447886105625739026433810851259760829112944769101557865474935245672310638931107468523492780934936765177674292815155262435831801499197874311121773797041186075024766460977392150443756520782067581277504082923534736776769428755807994035936082391356053079235986552374148782993815118221184577434597115748782910244569004818550079464590913826457003648367784164127206743005342001738754989548942975587267990706541155643222851974488533666334645686774107285018775831028090338485586011974337654011592698463713316522811656340001557779270632991105803230612916547576906583473846558419296181503108603192226769399675726201078322763163049259981181392937623116600712403297821389573627700886912737873588300406211047759637045071918185425658854059386338495534747471846997768166929630988406668430381834420429162324755162023168406793544828390933856260762963763336528787421503582319435368755435181752783296341241853932276334886271511786779019664786845658323166852266264286516275919963650402345264649287569303300048733672208950281055894539145902913252578285197293
c = 15640629897212089539145769625632189125456455778939633021487666539864477884226491831177051620671080345905237001384943044362508550274499601386018436774667054082051013986880044122234840762034425906802733285008515019104201964058459074727958015931524254616901569333808897189148422139163755426336008738228206905929505993240834181441728434782721945966055987934053102520300610949003828413057299830995512963516437591775582556040505553674525293788223483574494286570201177694289787659662521910225641898762643794474678297891552856073420478752076393386273627970575228665003851968484998550564390747988844710818619836079384152470450659391941581654509659766292902961171668168368723759124230712832393447719252348647172524453163783833358048230752476923663730556409340711188698221222770394308685941050292404627088273158846156984693358388590950279445736394513497524120008211955634017212917792675498853686681402944487402749561864649175474956913910853930952329280207751998559039169086898605565528308806524495500398924972480453453358088625940892246551961178561037313833306804342494449584581485895266308393917067830433039476096285467849735814999851855709235986958845331235439845410800486470278105793922000390078444089105955677711315740050638
e = 65537
phi = 50630446119693744932461043333634783952051644613410121323489034422807019677354031739581870482619482860819343267054008700977659650718829660461876942893133477358593434676989586248177570454365001582389610668271321166565650228525780765989609094461220562408822736334977906611729138831495445185451623783975295039557448719141834661301339760916576010363494254684260206557703260308938319802628615765422490143303529563080526610841724840591497599497360984340956739856808175441141377318213666570788835355471236387209017427892378341022650827644422889938135411113030082353658208901971976350841884168102577265906610030720102052642431165813898438042427758601167728641439100076464696070534292418692769437821099336065417871836318616267748948100850767083401006701653842285810851463941603607993871506802916872636491885159050459177091144835682790614678827490727138198753404587783007010636851848804247653604973416488483436564313254309247613450920163788495274159250259350308019456989775542822771334995680378173998980030514255202267440777540243752596967787419550405974660231031461184788339891694891682898269179384007727265853852557473219616275869787754919630376462425596077316475121261511652147200000000000000000000000000000000000000000000000

d = pow(e, -1, phi)

decoded = pow(c, d, n)
print(hex(decoded))
