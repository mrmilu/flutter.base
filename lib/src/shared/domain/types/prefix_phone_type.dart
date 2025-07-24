import 'package:flutter/material.dart';

import '../../../shared/helpers/extensions.dart';

enum PrefixPhoneType {
  spain(code: 'ES', prefix: '+34', mask: '000 000 000'),
  germany(code: 'DE', prefix: '+49', mask: '000 000 000'),
  unitedKingdom(code: 'GB', prefix: '+44', mask: '0000 000000'),
  norway(code: 'NO', prefix: '+47', mask: '000 00 000'),
  sweden(code: 'SE', prefix: '+46', mask: '000 000 000'),
  finland(code: 'FI', prefix: '+358', mask: '000 000 000'),
  italy(code: 'IT', prefix: '+39', mask: '000 000 000'),
  portugal(code: 'PT', prefix: '+351', mask: '000 000 000'),
  france(code: 'FR', prefix: '+33', mask: '000 000 000'),
  afghanistan(code: 'AF', prefix: '+93', mask: '000 000 000'),
  albania(code: 'AL', prefix: '+355', mask: '000 000 000'),
  andorra(code: 'AD', prefix: '+376', mask: '000 000'),
  angola(code: 'AO', prefix: '+244', mask: '000 000 000'),
  antiguaAndBarbuda(code: 'AG', prefix: '+1268', mask: '000 000 0000'),
  saudiArabia(code: 'SA', prefix: '+966', mask: '000 000 000'),
  algeria(code: 'DZ', prefix: '+213', mask: '000 000 000'),
  argentina(code: 'AR', prefix: '+54', mask: '000 000 0000'),
  armenia(code: 'AM', prefix: '+374', mask: '000 000 00'),
  australia(code: 'AU', prefix: '+61', mask: '000 000 000'),
  austria(code: 'AT', prefix: '+43', mask: '000 000 000'),
  azerbaijan(code: 'AZ', prefix: '+994', mask: '000 000 000'),
  bahamas(code: 'BS', prefix: '+1242', mask: '000 000 0000'),
  bangladesh(code: 'BD', prefix: '+880', mask: '0000 000 000'),
  barbados(code: 'BB', prefix: '+1246', mask: '000 000 0000'),
  bahrain(code: 'BH', prefix: '+973', mask: '0000 0000'),
  belize(code: 'BZ', prefix: '+501', mask: '000 0000'),
  benin(code: 'BJ', prefix: '+229', mask: '00 00 00 00'),
  belarus(code: 'BY', prefix: '+375', mask: '000 000 000'),
  myanmar(code: 'MM', prefix: '+95', mask: '000 000 000'),
  bolivia(code: 'BO', prefix: '+591', mask: '0000 0000'),
  bosniaAndHerzegovina(code: 'BA', prefix: '+387', mask: '000 000 000'),
  botswana(code: 'BW', prefix: '+267', mask: '00 000 000'),
  brazil(code: 'BR', prefix: '+55', mask: '00 00000 0000'),
  brunei(code: 'BN', prefix: '+673', mask: '000 0000'),
  bulgaria(code: 'BG', prefix: '+359', mask: '000 000 000'),
  burkinaFaso(code: 'BF', prefix: '+226', mask: '00 00 00 00'),
  burundi(code: 'BI', prefix: '+257', mask: '00 00 00 00'),
  bhutan(code: 'BT', prefix: '+975', mask: '00 000 000'),
  belgium(code: 'BE', prefix: '+32', mask: '000 000 000'),
  capeVerde(code: 'CV', prefix: '+238', mask: '000 00 00'),
  cambodia(code: 'KH', prefix: '+855', mask: '00 000 000'),
  cameroon(code: 'CM', prefix: '+237', mask: '00 00 00 00'),
  canada(code: 'CA', prefix: '+1', mask: '000 000 0000'),
  qatar(code: 'QA', prefix: '+974', mask: '0000 0000'),
  chad(code: 'TD', prefix: '+235', mask: '00 00 00 00'),
  chile(code: 'CL', prefix: '+56', mask: '0 0000 0000'),
  china(code: 'CN', prefix: '+86', mask: '000 0000 0000'),
  cyprus(code: 'CY', prefix: '+357', mask: '00 000 000'),
  vaticanCity(code: 'VA', prefix: '+3906', mask: '000 000 000'),
  colombia(code: 'CO', prefix: '+57', mask: '000 000 0000'),
  comoros(code: 'KM', prefix: '+269', mask: '00 000 00'),
  congo(code: 'CG', prefix: '+242', mask: '00 000 0000'),
  northKorea(code: 'KP', prefix: '+850', mask: '000 000 000'),
  southKorea(code: 'KR', prefix: '+82', mask: '00 0000 0000'),
  costaRica(code: 'CR', prefix: '+506', mask: '0000 0000'),
  ivoryCoast(code: 'CI', prefix: '+225', mask: '00 00 00 00'),
  croatia(code: 'HR', prefix: '+385', mask: '000 000 000'),
  cuba(code: 'CU', prefix: '+53', mask: '00 000 0000'),
  denmark(code: 'DK', prefix: '+45', mask: '00 00 00 00'),
  dominica(code: 'DM', prefix: '+1767', mask: '000 000 0000'),
  ecuador(code: 'EC', prefix: '+593', mask: '00 000 0000'),
  egypt(code: 'EG', prefix: '+20', mask: '000 000 0000'),
  elSalvador(code: 'SV', prefix: '+503', mask: '0000 0000'),
  unitedArabEmirates(code: 'AE', prefix: '+971', mask: '00 000 0000'),
  eritrea(code: 'ER', prefix: '+291', mask: '00 000 000'),
  slovakia(code: 'SK', prefix: '+421', mask: '000 000 000'),
  slovenia(code: 'SI', prefix: '+386', mask: '000 000 00'),
  unitedStates(code: 'US', prefix: '+1', mask: '000 000 0000'),
  estonia(code: 'EE', prefix: '+372', mask: '000 000 00'),
  eswatini(code: 'SZ', prefix: '+268', mask: '00 00 00 00'),
  ethiopia(code: 'ET', prefix: '+251', mask: '00 000 0000'),
  philippines(code: 'PH', prefix: '+63', mask: '000 000 0000'),
  fiji(code: 'FJ', prefix: '+679', mask: '000 0000'),
  gabon(code: 'GA', prefix: '+241', mask: '00 000 000'),
  gambia(code: 'GM', prefix: '+220', mask: '000 0000'),
  georgia(code: 'GE', prefix: '+995', mask: '000 000 000'),
  ghana(code: 'GH', prefix: '+233', mask: '000 000 000'),
  grenada(code: 'GD', prefix: '+1473', mask: '000 000 0000'),
  greece(code: 'GR', prefix: '+30', mask: '000 000 0000'),
  guatemala(code: 'GT', prefix: '+502', mask: '0000 0000'),
  guinea(code: 'GN', prefix: '+224', mask: '000 00 00 00'),
  equatorialGuinea(code: 'GQ', prefix: '+240', mask: '000 000 000'),
  guineaBissau(code: 'GW', prefix: '+245', mask: '000 000 000'),
  guyana(code: 'GY', prefix: '+592', mask: '000 0000'),
  haiti(code: 'HT', prefix: '+509', mask: '0000 0000'),
  honduras(code: 'HN', prefix: '+504', mask: '0000 0000'),
  hungary(code: 'HU', prefix: '+36', mask: '00 000 0000'),
  india(code: 'IN', prefix: '+91', mask: '00000 00000'),
  indonesia(code: 'ID', prefix: '+62', mask: '000 000 0000'),
  iraq(code: 'IQ', prefix: '+964', mask: '000 000 0000'),
  ireland(code: 'IE', prefix: '+353', mask: '000 000 000'),
  iran(code: 'IR', prefix: '+98', mask: '000 000 0000'),
  iceland(code: 'IS', prefix: '+354', mask: '000 0000'),
  marshallIslands(code: 'MH', prefix: '+692', mask: '000 0000'),
  solomonIslands(code: 'SB', prefix: '+677', mask: '000 0000'),
  israel(code: 'IL', prefix: '+972', mask: '00 000 0000'),
  jamaica(code: 'JM', prefix: '+1876', mask: '000 000 0000'),
  japan(code: 'JP', prefix: '+81', mask: '000 0000 0000'),
  jordan(code: 'JO', prefix: '+962', mask: '00 000 0000'),
  kazakhstan(code: 'KZ', prefix: '+7', mask: '000 000 0000'),
  kenya(code: 'KE', prefix: '+254', mask: '000 000 000'),
  kyrgyzstan(code: 'KG', prefix: '+996', mask: '000 000 000'),
  kiribati(code: 'KI', prefix: '+686', mask: '000 000 00'),
  kuwait(code: 'KW', prefix: '+965', mask: '0000 0000'),
  laos(code: 'LA', prefix: '+856', mask: '00 000 0000'),
  lesotho(code: 'LS', prefix: '+266', mask: '00 00 00 00'),
  latvia(code: 'LV', prefix: '+371', mask: '00 000 000'),
  liberia(code: 'LR', prefix: '+231', mask: '00 000 0000'),
  libya(code: 'LY', prefix: '+218', mask: '00 000 0000'),
  liechtenstein(code: 'LI', prefix: '+423', mask: '000 000 000'),
  lithuania(code: 'LT', prefix: '+370', mask: '000 000 00'),
  luxembourg(code: 'LU', prefix: '+352', mask: '000 000 000'),
  lebanon(code: 'LB', prefix: '+961', mask: '00 000 000'),
  madagascar(code: 'MG', prefix: '+261', mask: '00 000 00 00'),
  malaysia(code: 'MY', prefix: '+60', mask: '00 000 0000'),
  malawi(code: 'MW', prefix: '+265', mask: '00 000 0000'),
  maldives(code: 'MV', prefix: '+960', mask: '000 0000'),
  malta(code: 'MT', prefix: '+356', mask: '0000 0000'),
  mali(code: 'ML', prefix: '+223', mask: '00 00 00 00'),
  morocco(code: 'MA', prefix: '+212', mask: '00 000 0000'),
  mauritius(code: 'MU', prefix: '+230', mask: '0000 0000'),
  mauritania(code: 'MR', prefix: '+222', mask: '00 00 00 00'),
  micronesia(code: 'FM', prefix: '+691', mask: '000 0000'),
  moldova(code: 'MD', prefix: '+373', mask: '000 000 00'),
  mongolia(code: 'MN', prefix: '+976', mask: '00 00 00 00'),
  montenegro(code: 'ME', prefix: '+382', mask: '000 000 000'),
  mozambique(code: 'MZ', prefix: '+258', mask: '00 000 0000'),
  mexico(code: 'MX', prefix: '+52', mask: '00 0000 0000'),
  monaco(code: 'MC', prefix: '+377', mask: '000 000 000'),
  namibia(code: 'NA', prefix: '+264', mask: '00 000 0000'),
  nauru(code: 'NR', prefix: '+674', mask: '000 0000'),
  nepal(code: 'NP', prefix: '+977', mask: '00 000 0000'),
  nicaragua(code: 'NI', prefix: '+505', mask: '0000 0000'),
  nigeria(code: 'NG', prefix: '+234', mask: '000 000 0000'),
  newZealand(code: 'NZ', prefix: '+64', mask: '00 000 0000'),
  niger(code: 'NE', prefix: '+227', mask: '00 00 00 00'),
  oman(code: 'OM', prefix: '+968', mask: '00 00 00 00'),
  pakistan(code: 'PK', prefix: '+92', mask: '000 000 0000'),
  palau(code: 'PW', prefix: '+680', mask: '000 0000'),
  panama(code: 'PA', prefix: '+507', mask: '0000 0000'),
  papuaNewGuinea(code: 'PG', prefix: '+675', mask: '00 000 0000'),
  paraguay(code: 'PY', prefix: '+595', mask: '000 000 000'),
  netherlands(code: 'NL', prefix: '+31', mask: '00 000 0000'),
  peru(code: 'PE', prefix: '+51', mask: '000 000 000'),
  poland(code: 'PL', prefix: '+48', mask: '000 000 000'),
  centralAfricanRepublic(code: 'CF', prefix: '+236', mask: '00 00 00 00'),
  czechRepublic(code: 'CZ', prefix: '+420', mask: '000 000 000'),
  democraticRepublicOfCongo(code: 'CD', prefix: '+243', mask: '00 000 0000'),
  dominicanRepublic(code: 'DO', prefix: '+1809', mask: '000 000 0000'),
  republicOfCongo(code: 'RC', prefix: '+242', mask: '00 000 0000'),
  rwanda(code: 'RW', prefix: '+250', mask: '000 000 000'),
  romania(code: 'RO', prefix: '+40', mask: '000 000 000'),
  russia(code: 'RU', prefix: '+7', mask: '000 000 0000'),
  samoa(code: 'WS', prefix: '+685', mask: '00 000 00'),
  saintKittsAndNevis(code: 'KN', prefix: '+1869', mask: '000 000 0000'),
  sanMarino(code: 'SM', prefix: '+378', mask: '000 000 0000'),
  saintVincentAndGrenadines(code: 'VC', prefix: '+1784', mask: '000 000 0000'),
  saintLucia(code: 'LC', prefix: '+1758', mask: '000 000 0000'),
  saoTomeAndPrincipe(code: 'ST', prefix: '+239', mask: '000 0000'),
  senegal(code: 'SN', prefix: '+221', mask: '00 000 0000'),
  serbia(code: 'RS', prefix: '+381', mask: '000 000 000'),
  seychelles(code: 'SC', prefix: '+248', mask: '0 000 000'),
  sierraLeone(code: 'SL', prefix: '+232', mask: '00 000 000'),
  singapore(code: 'SG', prefix: '+65', mask: '0000 0000'),
  syria(code: 'SY', prefix: '+963', mask: '00 000 0000'),
  somalia(code: 'SO', prefix: '+252', mask: '00 000 0000'),
  sriLanka(code: 'LK', prefix: '+94', mask: '00 000 0000'),
  southAfrica(code: 'ZA', prefix: '+27', mask: '00 000 0000'),
  sudan(code: 'SD', prefix: '+249', mask: '00 000 0000'),
  southSudan(code: 'SS', prefix: '+211', mask: '00 000 0000'),
  switzerland(code: 'CH', prefix: '+41', mask: '00 000 0000'),
  suriname(code: 'SR', prefix: '+597', mask: '000 0000'),
  thailand(code: 'TH', prefix: '+66', mask: '00 000 0000'),
  tanzania(code: 'TZ', prefix: '+255', mask: '00 000 0000'),
  tajikistan(code: 'TJ', prefix: '+992', mask: '00 000 0000'),
  eastTimor(code: 'TL', prefix: '+670', mask: '000 000 00'),
  togo(code: 'TG', prefix: '+228', mask: '00 00 00 00'),
  tonga(code: 'TO', prefix: '+676', mask: '00 000'),
  trinidadAndTobago(code: 'TT', prefix: '+1868', mask: '000 000 0000'),
  turkmenistan(code: 'TM', prefix: '+993', mask: '0 000 0000'),
  turkey(code: 'TR', prefix: '+90', mask: '000 000 0000'),
  tuvalu(code: 'TV', prefix: '+688', mask: '00 000'),
  tunisia(code: 'TN', prefix: '+216', mask: '00 000 000'),
  ukraine(code: 'UA', prefix: '+380', mask: '000 000 000'),
  uganda(code: 'UG', prefix: '+256', mask: '000 000 000'),
  uruguay(code: 'UY', prefix: '+598', mask: '0 000 00 00'),
  uzbekistan(code: 'UZ', prefix: '+998', mask: '00 000 0000'),
  vanuatu(code: 'VU', prefix: '+678', mask: '00 000 00'),
  venezuela(code: 'VE', prefix: '+58', mask: '000 000 0000'),
  vietnam(code: 'VN', prefix: '+84', mask: '00 000 0000'),
  yemen(code: 'YE', prefix: '+967', mask: '00 000 0000'),
  djibouti(code: 'DJ', prefix: '+253', mask: '00 00 00 00'),
  zambia(code: 'ZM', prefix: '+260', mask: '00 000 0000'),
  zimbabwe(code: 'ZW', prefix: '+263', mask: '00 000 0000');

  final String code;
  final String prefix;
  final String mask;
  const PrefixPhoneType({
    required this.code,
    required this.prefix,
    required this.mask,
  });

  R map<R>({
    required R Function() spain,
    required R Function() germany,
    required R Function() unitedKingdom,
    required R Function() norway,
    required R Function() sweden,
    required R Function() finland,
    required R Function() italy,
    required R Function() portugal,
    required R Function() france,
    required R Function() afghanistan,
    required R Function() albania,
    required R Function() andorra,
    required R Function() angola,
    required R Function() antiguaAndBarbuda,
    required R Function() saudiArabia,
    required R Function() algeria,
    required R Function() argentina,
    required R Function() armenia,
    required R Function() australia,
    required R Function() austria,
    required R Function() azerbaijan,
    required R Function() bahamas,
    required R Function() bangladesh,
    required R Function() barbados,
    required R Function() bahrain,
    required R Function() belize,
    required R Function() benin,
    required R Function() belarus,
    required R Function() myanmar,
    required R Function() bolivia,
    required R Function() bosniaAndHerzegovina,
    required R Function() botswana,
    required R Function() brazil,
    required R Function() brunei,
    required R Function() bulgaria,
    required R Function() burkinaFaso,
    required R Function() burundi,
    required R Function() bhutan,
    required R Function() belgium,
    required R Function() capeVerde,
    required R Function() cambodia,
    required R Function() cameroon,
    required R Function() canada,
    required R Function() qatar,
    required R Function() chad,
    required R Function() chile,
    required R Function() china,
    required R Function() cyprus,
    required R Function() vaticanCity,
    required R Function() colombia,
    required R Function() comoros,
    required R Function() congo,
    required R Function() northKorea,
    required R Function() southKorea,
    required R Function() costaRica,
    required R Function() ivoryCoast,
    required R Function() croatia,
    required R Function() cuba,
    required R Function() denmark,
    required R Function() dominica,
    required R Function() ecuador,
    required R Function() egypt,
    required R Function() elSalvador,
    required R Function() unitedArabEmirates,
    required R Function() eritrea,
    required R Function() slovakia,
    required R Function() slovenia,
    required R Function() unitedStates,
    required R Function() estonia,
    required R Function() eswatini,
    required R Function() ethiopia,
    required R Function() philippines,
    required R Function() fiji,
    required R Function() gabon,
    required R Function() gambia,
    required R Function() georgia,
    required R Function() ghana,
    required R Function() grenada,
    required R Function() greece,
    required R Function() guatemala,
    required R Function() guinea,
    required R Function() equatorialGuinea,
    required R Function() guineaBissau,
    required R Function() guyana,
    required R Function() haiti,
    required R Function() honduras,
    required R Function() hungary,
    required R Function() india,
    required R Function() indonesia,
    required R Function() iraq,
    required R Function() ireland,
    required R Function() iran,
    required R Function() iceland,
    required R Function() marshallIslands,
    required R Function() solomonIslands,
    required R Function() israel,
    required R Function() jamaica,
    required R Function() japan,
    required R Function() jordan,
    required R Function() kazakhstan,
    required R Function() kenya,
    required R Function() kyrgyzstan,
    required R Function() kiribati,
    required R Function() kuwait,
    required R Function() laos,
    required R Function() lesotho,
    required R Function() latvia,
    required R Function() liberia,
    required R Function() libya,
    required R Function() liechtenstein,
    required R Function() lithuania,
    required R Function() luxembourg,
    required R Function() lebanon,
    required R Function() madagascar,
    required R Function() malaysia,
    required R Function() malawi,
    required R Function() maldives,
    required R Function() malta,
    required R Function() mali,
    required R Function() morocco,
    required R Function() mauritius,
    required R Function() mauritania,
    required R Function() micronesia,
    required R Function() moldova,
    required R Function() mongolia,
    required R Function() montenegro,
    required R Function() mozambique,
    required R Function() mexico,
    required R Function() monaco,
    required R Function() namibia,
    required R Function() nauru,
    required R Function() nepal,
    required R Function() nicaragua,
    required R Function() nigeria,
    required R Function() newZealand,
    required R Function() niger,
    required R Function() oman,
    required R Function() pakistan,
    required R Function() palau,
    required R Function() panama,
    required R Function() papuaNewGuinea,
    required R Function() paraguay,
    required R Function() netherlands,
    required R Function() peru,
    required R Function() poland,
    required R Function() centralAfricanRepublic,
    required R Function() czechRepublic,
    required R Function() democraticRepublicOfCongo,
    required R Function() dominicanRepublic,
    required R Function() republicOfCongo,
    required R Function() rwanda,
    required R Function() romania,
    required R Function() russia,
    required R Function() samoa,
    required R Function() saintKittsAndNevis,
    required R Function() sanMarino,
    required R Function() saintVincentAndGrenadines,
    required R Function() saintLucia,
    required R Function() saoTomeAndPrincipe,
    required R Function() senegal,
    required R Function() serbia,
    required R Function() seychelles,
    required R Function() sierraLeone,
    required R Function() singapore,
    required R Function() syria,
    required R Function() somalia,
    required R Function() sriLanka,
    required R Function() southAfrica,
    required R Function() sudan,
    required R Function() southSudan,
    required R Function() switzerland,
    required R Function() suriname,
    required R Function() thailand,
    required R Function() tanzania,
    required R Function() tajikistan,
    required R Function() eastTimor,
    required R Function() togo,
    required R Function() tonga,
    required R Function() trinidadAndTobago,
    required R Function() turkmenistan,
    required R Function() turkey,
    required R Function() tuvalu,
    required R Function() tunisia,
    required R Function() ukraine,
    required R Function() uganda,
    required R Function() uruguay,
    required R Function() uzbekistan,
    required R Function() vanuatu,
    required R Function() venezuela,
    required R Function() vietnam,
    required R Function() yemen,
    required R Function() djibouti,
    required R Function() zambia,
    required R Function() zimbabwe,
  }) {
    switch (this) {
      case PrefixPhoneType.spain:
        return spain();
      case PrefixPhoneType.germany:
        return germany();
      case PrefixPhoneType.unitedKingdom:
        return unitedKingdom();
      case PrefixPhoneType.norway:
        return norway();
      case PrefixPhoneType.sweden:
        return sweden();
      case PrefixPhoneType.finland:
        return finland();
      case PrefixPhoneType.italy:
        return italy();
      case PrefixPhoneType.portugal:
        return portugal();
      case PrefixPhoneType.france:
        return france();
      case PrefixPhoneType.afghanistan:
        return afghanistan();
      case PrefixPhoneType.albania:
        return albania();
      case PrefixPhoneType.andorra:
        return andorra();
      case PrefixPhoneType.angola:
        return angola();
      case PrefixPhoneType.antiguaAndBarbuda:
        return antiguaAndBarbuda();
      case PrefixPhoneType.saudiArabia:
        return saudiArabia();
      case PrefixPhoneType.algeria:
        return algeria();
      case PrefixPhoneType.argentina:
        return argentina();
      case PrefixPhoneType.armenia:
        return armenia();
      case PrefixPhoneType.australia:
        return australia();
      case PrefixPhoneType.austria:
        return austria();
      case PrefixPhoneType.azerbaijan:
        return azerbaijan();
      case PrefixPhoneType.bahamas:
        return bahamas();
      case PrefixPhoneType.bangladesh:
        return bangladesh();
      case PrefixPhoneType.barbados:
        return barbados();
      case PrefixPhoneType.bahrain:
        return bahrain();
      case PrefixPhoneType.belize:
        return belize();
      case PrefixPhoneType.benin:
        return benin();
      case PrefixPhoneType.belarus:
        return belarus();
      case PrefixPhoneType.myanmar:
        return myanmar();
      case PrefixPhoneType.bolivia:
        return bolivia();
      case PrefixPhoneType.bosniaAndHerzegovina:
        return bosniaAndHerzegovina();
      case PrefixPhoneType.botswana:
        return botswana();
      case PrefixPhoneType.brazil:
        return brazil();
      case PrefixPhoneType.brunei:
        return brunei();
      case PrefixPhoneType.bulgaria:
        return bulgaria();
      case PrefixPhoneType.burkinaFaso:
        return burkinaFaso();
      case PrefixPhoneType.burundi:
        return burundi();
      case PrefixPhoneType.bhutan:
        return bhutan();
      case PrefixPhoneType.belgium:
        return belgium();
      case PrefixPhoneType.capeVerde:
        return capeVerde();
      case PrefixPhoneType.cambodia:
        return cambodia();
      case PrefixPhoneType.cameroon:
        return cameroon();
      case PrefixPhoneType.canada:
        return canada();
      case PrefixPhoneType.qatar:
        return qatar();
      case PrefixPhoneType.chad:
        return chad();
      case PrefixPhoneType.chile:
        return chile();
      case PrefixPhoneType.china:
        return china();
      case PrefixPhoneType.cyprus:
        return cyprus();
      case PrefixPhoneType.vaticanCity:
        return vaticanCity();
      case PrefixPhoneType.colombia:
        return colombia();
      case PrefixPhoneType.comoros:
        return comoros();
      case PrefixPhoneType.congo:
        return congo();
      case PrefixPhoneType.northKorea:
        return northKorea();
      case PrefixPhoneType.southKorea:
        return southKorea();
      case PrefixPhoneType.costaRica:
        return costaRica();
      case PrefixPhoneType.ivoryCoast:
        return ivoryCoast();
      case PrefixPhoneType.croatia:
        return croatia();
      case PrefixPhoneType.cuba:
        return cuba();
      case PrefixPhoneType.denmark:
        return denmark();
      case PrefixPhoneType.dominica:
        return dominica();
      case PrefixPhoneType.ecuador:
        return ecuador();
      case PrefixPhoneType.egypt:
        return egypt();
      case PrefixPhoneType.elSalvador:
        return elSalvador();
      case PrefixPhoneType.unitedArabEmirates:
        return unitedArabEmirates();
      case PrefixPhoneType.eritrea:
        return eritrea();
      case PrefixPhoneType.slovakia:
        return slovakia();
      case PrefixPhoneType.slovenia:
        return slovenia();
      case PrefixPhoneType.unitedStates:
        return unitedStates();
      case PrefixPhoneType.estonia:
        return estonia();
      case PrefixPhoneType.eswatini:
        return eswatini();
      case PrefixPhoneType.ethiopia:
        return ethiopia();
      case PrefixPhoneType.philippines:
        return philippines();
      case PrefixPhoneType.fiji:
        return fiji();
      case PrefixPhoneType.gabon:
        return gabon();
      case PrefixPhoneType.gambia:
        return gambia();
      case PrefixPhoneType.georgia:
        return georgia();
      case PrefixPhoneType.ghana:
        return ghana();
      case PrefixPhoneType.grenada:
        return grenada();
      case PrefixPhoneType.greece:
        return greece();
      case PrefixPhoneType.guatemala:
        return guatemala();
      case PrefixPhoneType.guinea:
        return guinea();
      case PrefixPhoneType.equatorialGuinea:
        return equatorialGuinea();
      case PrefixPhoneType.guineaBissau:
        return guineaBissau();
      case PrefixPhoneType.guyana:
        return guyana();
      case PrefixPhoneType.haiti:
        return haiti();
      case PrefixPhoneType.honduras:
        return honduras();
      case PrefixPhoneType.hungary:
        return hungary();
      case PrefixPhoneType.india:
        return india();
      case PrefixPhoneType.indonesia:
        return indonesia();
      case PrefixPhoneType.iraq:
        return iraq();
      case PrefixPhoneType.ireland:
        return ireland();
      case PrefixPhoneType.iran:
        return iran();
      case PrefixPhoneType.iceland:
        return iceland();
      case PrefixPhoneType.marshallIslands:
        return marshallIslands();
      case PrefixPhoneType.solomonIslands:
        return solomonIslands();
      case PrefixPhoneType.israel:
        return israel();
      case PrefixPhoneType.jamaica:
        return jamaica();
      case PrefixPhoneType.japan:
        return japan();
      case PrefixPhoneType.jordan:
        return jordan();
      case PrefixPhoneType.kazakhstan:
        return kazakhstan();
      case PrefixPhoneType.kenya:
        return kenya();
      case PrefixPhoneType.kyrgyzstan:
        return kyrgyzstan();
      case PrefixPhoneType.kiribati:
        return kiribati();
      case PrefixPhoneType.kuwait:
        return kuwait();
      case PrefixPhoneType.laos:
        return laos();
      case PrefixPhoneType.lesotho:
        return lesotho();
      case PrefixPhoneType.latvia:
        return latvia();
      case PrefixPhoneType.liberia:
        return liberia();
      case PrefixPhoneType.libya:
        return libya();
      case PrefixPhoneType.liechtenstein:
        return liechtenstein();
      case PrefixPhoneType.lithuania:
        return lithuania();
      case PrefixPhoneType.luxembourg:
        return luxembourg();
      case PrefixPhoneType.lebanon:
        return lebanon();
      case PrefixPhoneType.madagascar:
        return madagascar();
      case PrefixPhoneType.malaysia:
        return malaysia();
      case PrefixPhoneType.malawi:
        return malawi();
      case PrefixPhoneType.maldives:
        return maldives();
      case PrefixPhoneType.malta:
        return malta();
      case PrefixPhoneType.mali:
        return mali();
      case PrefixPhoneType.morocco:
        return morocco();
      case PrefixPhoneType.mauritius:
        return mauritius();
      case PrefixPhoneType.mauritania:
        return mauritania();
      case PrefixPhoneType.micronesia:
        return micronesia();
      case PrefixPhoneType.moldova:
        return moldova();
      case PrefixPhoneType.mongolia:
        return mongolia();
      case PrefixPhoneType.montenegro:
        return montenegro();
      case PrefixPhoneType.mozambique:
        return mozambique();
      case PrefixPhoneType.mexico:
        return mexico();
      case PrefixPhoneType.monaco:
        return monaco();
      case PrefixPhoneType.namibia:
        return namibia();
      case PrefixPhoneType.nauru:
        return nauru();
      case PrefixPhoneType.nepal:
        return nepal();
      case PrefixPhoneType.nicaragua:
        return nicaragua();
      case PrefixPhoneType.nigeria:
        return nigeria();
      case PrefixPhoneType.newZealand:
        return newZealand();
      case PrefixPhoneType.niger:
        return niger();
      case PrefixPhoneType.oman:
        return oman();
      case PrefixPhoneType.pakistan:
        return pakistan();
      case PrefixPhoneType.palau:
        return palau();
      case PrefixPhoneType.panama:
        return panama();
      case PrefixPhoneType.papuaNewGuinea:
        return papuaNewGuinea();
      case PrefixPhoneType.paraguay:
        return paraguay();
      case PrefixPhoneType.netherlands:
        return netherlands();
      case PrefixPhoneType.peru:
        return peru();
      case PrefixPhoneType.poland:
        return poland();
      case PrefixPhoneType.centralAfricanRepublic:
        return centralAfricanRepublic();
      case PrefixPhoneType.czechRepublic:
        return czechRepublic();
      case PrefixPhoneType.democraticRepublicOfCongo:
        return democraticRepublicOfCongo();
      case PrefixPhoneType.dominicanRepublic:
        return dominicanRepublic();
      case PrefixPhoneType.republicOfCongo:
        return republicOfCongo();
      case PrefixPhoneType.rwanda:
        return rwanda();
      case PrefixPhoneType.romania:
        return romania();
      case PrefixPhoneType.russia:
        return russia();
      case PrefixPhoneType.samoa:
        return samoa();
      case PrefixPhoneType.saintKittsAndNevis:
        return saintKittsAndNevis();
      case PrefixPhoneType.sanMarino:
        return sanMarino();
      case PrefixPhoneType.saintVincentAndGrenadines:
        return saintVincentAndGrenadines();
      case PrefixPhoneType.saintLucia:
        return saintLucia();
      case PrefixPhoneType.saoTomeAndPrincipe:
        return saoTomeAndPrincipe();
      case PrefixPhoneType.senegal:
        return senegal();
      case PrefixPhoneType.serbia:
        return serbia();
      case PrefixPhoneType.seychelles:
        return seychelles();
      case PrefixPhoneType.sierraLeone:
        return sierraLeone();
      case PrefixPhoneType.singapore:
        return singapore();
      case PrefixPhoneType.syria:
        return syria();
      case PrefixPhoneType.somalia:
        return somalia();
      case PrefixPhoneType.sriLanka:
        return sriLanka();
      case PrefixPhoneType.southAfrica:
        return southAfrica();
      case PrefixPhoneType.sudan:
        return sudan();
      case PrefixPhoneType.southSudan:
        return southSudan();
      case PrefixPhoneType.switzerland:
        return switzerland();
      case PrefixPhoneType.suriname:
        return suriname();
      case PrefixPhoneType.thailand:
        return thailand();
      case PrefixPhoneType.tanzania:
        return tanzania();
      case PrefixPhoneType.tajikistan:
        return tajikistan();
      case PrefixPhoneType.eastTimor:
        return eastTimor();
      case PrefixPhoneType.togo:
        return togo();
      case PrefixPhoneType.tonga:
        return tonga();
      case PrefixPhoneType.trinidadAndTobago:
        return trinidadAndTobago();
      case PrefixPhoneType.turkmenistan:
        return turkmenistan();
      case PrefixPhoneType.turkey:
        return turkey();
      case PrefixPhoneType.tuvalu:
        return tuvalu();
      case PrefixPhoneType.tunisia:
        return tunisia();
      case PrefixPhoneType.ukraine:
        return ukraine();
      case PrefixPhoneType.uganda:
        return uganda();
      case PrefixPhoneType.uruguay:
        return uruguay();
      case PrefixPhoneType.uzbekistan:
        return uzbekistan();
      case PrefixPhoneType.vanuatu:
        return vanuatu();
      case PrefixPhoneType.venezuela:
        return venezuela();
      case PrefixPhoneType.vietnam:
        return vietnam();
      case PrefixPhoneType.yemen:
        return yemen();
      case PrefixPhoneType.djibouti:
        return djibouti();
      case PrefixPhoneType.zambia:
        return zambia();
      case PrefixPhoneType.zimbabwe:
        return zimbabwe();
    }
  }

  static PrefixPhoneType getByPrefix(String prefix) {
    return PrefixPhoneType.values.firstWhereOrNull(
          (type) => type.prefix.toLowerCase() == prefix.toLowerCase(),
        ) ??
        PrefixPhoneType.spain;
  }

  @override
  String toString() {
    switch (this) {
      case PrefixPhoneType.spain:
        return 'spain';
      case PrefixPhoneType.germany:
        return 'germany';
      case PrefixPhoneType.unitedKingdom:
        return 'unitedKingdom';
      case PrefixPhoneType.norway:
        return 'norway';
      case PrefixPhoneType.sweden:
        return 'sweden';
      case PrefixPhoneType.finland:
        return 'finland';
      case PrefixPhoneType.italy:
        return 'italy';
      case PrefixPhoneType.portugal:
        return 'portugal';
      case PrefixPhoneType.france:
        return 'france';
      case PrefixPhoneType.afghanistan:
        return 'afghanistan';
      case PrefixPhoneType.albania:
        return 'albania';
      case PrefixPhoneType.andorra:
        return 'andorra';
      case PrefixPhoneType.angola:
        return 'angola';
      case PrefixPhoneType.antiguaAndBarbuda:
        return 'antiguaAndBarbuda';
      case PrefixPhoneType.saudiArabia:
        return 'saudiArabia';
      case PrefixPhoneType.algeria:
        return 'algeria';
      case PrefixPhoneType.argentina:
        return 'argentina';
      case PrefixPhoneType.armenia:
        return 'armenia';
      case PrefixPhoneType.australia:
        return 'australia';
      case PrefixPhoneType.austria:
        return 'austria';
      case PrefixPhoneType.azerbaijan:
        return 'azerbaijan';
      case PrefixPhoneType.bahamas:
        return 'bahamas';
      case PrefixPhoneType.bangladesh:
        return 'bangladesh';
      case PrefixPhoneType.barbados:
        return 'barbados';
      case PrefixPhoneType.bahrain:
        return 'bahrain';
      case PrefixPhoneType.belize:
        return 'belize';
      case PrefixPhoneType.benin:
        return 'benin';
      case PrefixPhoneType.belarus:
        return 'belarus';
      case PrefixPhoneType.myanmar:
        return 'myanmar';
      case PrefixPhoneType.bolivia:
        return 'bolivia';
      case PrefixPhoneType.bosniaAndHerzegovina:
        return 'bosniaAndHerzegovina';
      case PrefixPhoneType.botswana:
        return 'botswana';
      case PrefixPhoneType.brazil:
        return 'brazil';
      case PrefixPhoneType.brunei:
        return 'brunei';
      case PrefixPhoneType.bulgaria:
        return 'bulgaria';
      case PrefixPhoneType.burkinaFaso:
        return 'burkinaFaso';
      case PrefixPhoneType.burundi:
        return 'burundi';
      case PrefixPhoneType.bhutan:
        return 'bhutan';
      case PrefixPhoneType.belgium:
        return 'belgium';
      case PrefixPhoneType.capeVerde:
        return 'capeVerde';
      case PrefixPhoneType.cambodia:
        return 'cambodia';
      case PrefixPhoneType.cameroon:
        return 'cameroon';
      case PrefixPhoneType.canada:
        return 'canada';
      case PrefixPhoneType.qatar:
        return 'qatar';
      case PrefixPhoneType.chad:
        return 'chad';
      case PrefixPhoneType.chile:
        return 'chile';
      case PrefixPhoneType.china:
        return 'china';
      case PrefixPhoneType.cyprus:
        return 'cyprus';
      case PrefixPhoneType.vaticanCity:
        return 'vaticanCity';
      case PrefixPhoneType.colombia:
        return 'colombia';
      case PrefixPhoneType.comoros:
        return 'comoros';
      case PrefixPhoneType.congo:
        return 'congo';
      case PrefixPhoneType.northKorea:
        return 'northKorea';
      case PrefixPhoneType.southKorea:
        return 'southKorea';
      case PrefixPhoneType.costaRica:
        return 'costaRica';
      case PrefixPhoneType.ivoryCoast:
        return 'ivoryCoast';
      case PrefixPhoneType.croatia:
        return 'croatia';
      case PrefixPhoneType.cuba:
        return 'cuba';
      case PrefixPhoneType.denmark:
        return 'denmark';
      case PrefixPhoneType.dominica:
        return 'dominica';
      case PrefixPhoneType.ecuador:
        return 'ecuador';
      case PrefixPhoneType.egypt:
        return 'egypt';
      case PrefixPhoneType.elSalvador:
        return 'elSalvador';
      case PrefixPhoneType.unitedArabEmirates:
        return 'unitedArabEmirates';
      case PrefixPhoneType.eritrea:
        return 'eritrea';
      case PrefixPhoneType.slovakia:
        return 'slovakia';
      case PrefixPhoneType.slovenia:
        return 'slovenia';
      case PrefixPhoneType.unitedStates:
        return 'unitedStates';
      case PrefixPhoneType.estonia:
        return 'estonia';
      case PrefixPhoneType.eswatini:
        return 'eswatini';
      case PrefixPhoneType.ethiopia:
        return 'ethiopia';
      case PrefixPhoneType.philippines:
        return 'philippines';
      case PrefixPhoneType.fiji:
        return 'fiji';
      case PrefixPhoneType.gabon:
        return 'gabon';
      case PrefixPhoneType.gambia:
        return 'gambia';
      case PrefixPhoneType.georgia:
        return 'georgia';
      case PrefixPhoneType.ghana:
        return 'ghana';
      case PrefixPhoneType.grenada:
        return 'grenada';
      case PrefixPhoneType.greece:
        return 'greece';
      case PrefixPhoneType.guatemala:
        return 'guatemala';
      case PrefixPhoneType.guinea:
        return 'guinea';
      case PrefixPhoneType.equatorialGuinea:
        return 'equatorialGuinea';
      case PrefixPhoneType.guineaBissau:
        return 'guineaBissau';
      case PrefixPhoneType.guyana:
        return 'guyana';
      case PrefixPhoneType.haiti:
        return 'haiti';
      case PrefixPhoneType.honduras:
        return 'honduras';
      case PrefixPhoneType.hungary:
        return 'hungary';
      case PrefixPhoneType.india:
        return 'india';
      case PrefixPhoneType.indonesia:
        return 'indonesia';
      case PrefixPhoneType.iraq:
        return 'iraq';
      case PrefixPhoneType.ireland:
        return 'ireland';
      case PrefixPhoneType.iran:
        return 'iran';
      case PrefixPhoneType.iceland:
        return 'iceland';
      case PrefixPhoneType.marshallIslands:
        return 'marshallIslands';
      case PrefixPhoneType.solomonIslands:
        return 'solomonIslands';
      case PrefixPhoneType.israel:
        return 'israel';
      case PrefixPhoneType.jamaica:
        return 'jamaica';
      case PrefixPhoneType.japan:
        return 'japan';
      case PrefixPhoneType.jordan:
        return 'jordan';
      case PrefixPhoneType.kazakhstan:
        return 'kazakhstan';
      case PrefixPhoneType.kenya:
        return 'kenya';
      case PrefixPhoneType.kyrgyzstan:
        return 'kyrgyzstan';
      case PrefixPhoneType.kiribati:
        return 'kiribati';
      case PrefixPhoneType.kuwait:
        return 'kuwait';
      case PrefixPhoneType.laos:
        return 'laos';
      case PrefixPhoneType.lesotho:
        return 'lesotho';
      case PrefixPhoneType.latvia:
        return 'latvia';
      case PrefixPhoneType.liberia:
        return 'liberia';
      case PrefixPhoneType.libya:
        return 'libya';
      case PrefixPhoneType.liechtenstein:
        return 'liechtenstein';
      case PrefixPhoneType.lithuania:
        return 'lithuania';
      case PrefixPhoneType.luxembourg:
        return 'luxembourg';
      case PrefixPhoneType.lebanon:
        return 'lebanon';
      case PrefixPhoneType.madagascar:
        return 'madagascar';
      case PrefixPhoneType.malaysia:
        return 'malaysia';
      case PrefixPhoneType.malawi:
        return 'malawi';
      case PrefixPhoneType.maldives:
        return 'maldives';
      case PrefixPhoneType.malta:
        return 'malta';
      case PrefixPhoneType.mali:
        return 'mali';
      case PrefixPhoneType.morocco:
        return 'morocco';
      case PrefixPhoneType.mauritius:
        return 'mauritius';
      case PrefixPhoneType.mauritania:
        return 'mauritania';
      case PrefixPhoneType.micronesia:
        return 'micronesia';
      case PrefixPhoneType.moldova:
        return 'moldova';
      case PrefixPhoneType.mongolia:
        return 'mongolia';
      case PrefixPhoneType.montenegro:
        return 'montenegro';
      case PrefixPhoneType.mozambique:
        return 'mozambique';
      case PrefixPhoneType.mexico:
        return 'mexico';
      case PrefixPhoneType.monaco:
        return 'monaco';
      case PrefixPhoneType.namibia:
        return 'namibia';
      case PrefixPhoneType.nauru:
        return 'nauru';
      case PrefixPhoneType.nepal:
        return 'nepal';
      case PrefixPhoneType.nicaragua:
        return 'nicaragua';
      case PrefixPhoneType.nigeria:
        return 'nigeria';
      case PrefixPhoneType.newZealand:
        return 'newZealand';
      case PrefixPhoneType.niger:
        return 'niger';
      case PrefixPhoneType.oman:
        return 'oman';
      case PrefixPhoneType.pakistan:
        return 'pakistan';
      case PrefixPhoneType.palau:
        return 'palau';
      case PrefixPhoneType.panama:
        return 'panama';
      case PrefixPhoneType.papuaNewGuinea:
        return 'papuaNewGuinea';
      case PrefixPhoneType.paraguay:
        return 'paraguay';
      case PrefixPhoneType.netherlands:
        return 'netherlands';
      case PrefixPhoneType.peru:
        return 'peru';
      case PrefixPhoneType.poland:
        return 'poland';
      case PrefixPhoneType.centralAfricanRepublic:
        return 'centralAfricanRepublic';
      case PrefixPhoneType.czechRepublic:
        return 'czechRepublic';
      case PrefixPhoneType.democraticRepublicOfCongo:
        return 'democraticRepublicOfCongo';
      case PrefixPhoneType.dominicanRepublic:
        return 'dominicanRepublic';
      case PrefixPhoneType.republicOfCongo:
        return 'republicOfCongo';
      case PrefixPhoneType.rwanda:
        return 'rwanda';
      case PrefixPhoneType.romania:
        return 'romania';
      case PrefixPhoneType.russia:
        return 'russia';
      case PrefixPhoneType.samoa:
        return 'samoa';
      case PrefixPhoneType.saintKittsAndNevis:
        return 'saintKittsAndNevis';
      case PrefixPhoneType.sanMarino:
        return 'sanMarino';
      case PrefixPhoneType.saintVincentAndGrenadines:
        return 'saintVincentAndGrenadines';
      case PrefixPhoneType.saintLucia:
        return 'saintLucia';
      case PrefixPhoneType.saoTomeAndPrincipe:
        return 'saoTomeAndPrincipe';
      case PrefixPhoneType.senegal:
        return 'senegal';
      case PrefixPhoneType.serbia:
        return 'serbia';
      case PrefixPhoneType.seychelles:
        return 'seychelles';
      case PrefixPhoneType.sierraLeone:
        return 'sierraLeone';
      case PrefixPhoneType.singapore:
        return 'singapore';
      case PrefixPhoneType.syria:
        return 'syria';
      case PrefixPhoneType.somalia:
        return 'somalia';
      case PrefixPhoneType.sriLanka:
        return 'sriLanka';
      case PrefixPhoneType.southAfrica:
        return 'southAfrica';
      case PrefixPhoneType.sudan:
        return 'sudan';
      case PrefixPhoneType.southSudan:
        return 'southSudan';
      case PrefixPhoneType.switzerland:
        return 'switzerland';
      case PrefixPhoneType.suriname:
        return 'suriname';
      case PrefixPhoneType.thailand:
        return 'thailand';
      case PrefixPhoneType.tanzania:
        return 'tanzania';
      case PrefixPhoneType.tajikistan:
        return 'tajikistan';
      case PrefixPhoneType.eastTimor:
        return 'eastTimor';
      case PrefixPhoneType.togo:
        return 'togo';
      case PrefixPhoneType.tonga:
        return 'tonga';
      case PrefixPhoneType.trinidadAndTobago:
        return 'trinidadAndTobago';
      case PrefixPhoneType.turkmenistan:
        return 'turkmenistan';
      case PrefixPhoneType.turkey:
        return 'turkey';
      case PrefixPhoneType.tuvalu:
        return 'tuvalu';
      case PrefixPhoneType.tunisia:
        return 'tunisia';
      case PrefixPhoneType.ukraine:
        return 'ukraine';
      case PrefixPhoneType.uganda:
        return 'uganda';
      case PrefixPhoneType.uruguay:
        return 'uruguay';
      case PrefixPhoneType.uzbekistan:
        return 'uzbekistan';
      case PrefixPhoneType.vanuatu:
        return 'vanuatu';
      case PrefixPhoneType.venezuela:
        return 'venezuela';
      case PrefixPhoneType.vietnam:
        return 'vietnam';
      case PrefixPhoneType.yemen:
        return 'yemen';
      case PrefixPhoneType.djibouti:
        return 'djibouti';
      case PrefixPhoneType.zambia:
        return 'zambia';
      case PrefixPhoneType.zimbabwe:
        return 'zimbabwe';
    }
  }

  static PrefixPhoneType fromString(String status) {
    switch (status) {
      case 'spain':
        return PrefixPhoneType.spain;
      case 'germany':
        return PrefixPhoneType.germany;
      case 'unitedKingdom':
        return PrefixPhoneType.unitedKingdom;
      case 'norway':
        return PrefixPhoneType.norway;
      case 'sweden':
        return PrefixPhoneType.sweden;
      case 'finland':
        return PrefixPhoneType.finland;
      case 'italy':
        return PrefixPhoneType.italy;
      case 'portugal':
        return PrefixPhoneType.portugal;
      case 'france':
        return PrefixPhoneType.france;
      case 'afghanistan':
        return PrefixPhoneType.afghanistan;
      case 'albania':
        return PrefixPhoneType.albania;
      case 'andorra':
        return PrefixPhoneType.andorra;
      case 'angola':
        return PrefixPhoneType.angola;
      case 'antiguaAndBarbuda':
        return PrefixPhoneType.antiguaAndBarbuda;
      case 'saudiArabia':
        return PrefixPhoneType.saudiArabia;
      case 'algeria':
        return PrefixPhoneType.algeria;
      case 'argentina':
        return PrefixPhoneType.argentina;
      case 'armenia':
        return PrefixPhoneType.armenia;
      case 'australia':
        return PrefixPhoneType.australia;
      case 'austria':
        return PrefixPhoneType.austria;
      case 'azerbaijan':
        return PrefixPhoneType.azerbaijan;
      case 'bahamas':
        return PrefixPhoneType.bahamas;
      case 'bangladesh':
        return PrefixPhoneType.bangladesh;
      case 'barbados':
        return PrefixPhoneType.barbados;
      case 'bahrain':
        return PrefixPhoneType.bahrain;
      case 'belize':
        return PrefixPhoneType.belize;
      case 'benin':
        return PrefixPhoneType.benin;
      case 'belarus':
        return PrefixPhoneType.belarus;
      case 'myanmar':
        return PrefixPhoneType.myanmar;
      case 'bolivia':
        return PrefixPhoneType.bolivia;
      case 'bosniaAndHerzegovina':
        return PrefixPhoneType.bosniaAndHerzegovina;
      case 'botswana':
        return PrefixPhoneType.botswana;
      case 'brazil':
        return PrefixPhoneType.brazil;
      case 'brunei':
        return PrefixPhoneType.brunei;
      case 'bulgaria':
        return PrefixPhoneType.bulgaria;
      case 'burkinaFaso':
        return PrefixPhoneType.burkinaFaso;
      case 'burundi':
        return PrefixPhoneType.burundi;
      case 'bhutan':
        return PrefixPhoneType.bhutan;
      case 'belgium':
        return PrefixPhoneType.belgium;
      case 'capeVerde':
        return PrefixPhoneType.capeVerde;
      case 'cambodia':
        return PrefixPhoneType.cambodia;
      case 'cameroon':
        return PrefixPhoneType.cameroon;
      case 'canada':
        return PrefixPhoneType.canada;
      case 'qatar':
        return PrefixPhoneType.qatar;
      case 'chad':
        return PrefixPhoneType.chad;
      case 'chile':
        return PrefixPhoneType.chile;
      case 'china':
        return PrefixPhoneType.china;
      case 'cyprus':
        return PrefixPhoneType.cyprus;
      case 'vaticanCity':
        return PrefixPhoneType.vaticanCity;
      case 'colombia':
        return PrefixPhoneType.colombia;
      case 'comoros':
        return PrefixPhoneType.comoros;
      case 'congo':
        return PrefixPhoneType.congo;
      case 'northKorea':
        return PrefixPhoneType.northKorea;
      case 'southKorea':
        return PrefixPhoneType.southKorea;
      case 'costaRica':
        return PrefixPhoneType.costaRica;
      case 'ivoryCoast':
        return PrefixPhoneType.ivoryCoast;
      case 'croatia':
        return PrefixPhoneType.croatia;
      case 'cuba':
        return PrefixPhoneType.cuba;
      case 'denmark':
        return PrefixPhoneType.denmark;
      case 'dominica':
        return PrefixPhoneType.dominica;
      case 'ecuador':
        return PrefixPhoneType.ecuador;
      case 'egypt':
        return PrefixPhoneType.egypt;
      case 'elSalvador':
        return PrefixPhoneType.elSalvador;
      case 'unitedArabEmirates':
        return PrefixPhoneType.unitedArabEmirates;
      case 'eritrea':
        return PrefixPhoneType.eritrea;
      case 'slovakia':
        return PrefixPhoneType.slovakia;
      case 'slovenia':
        return PrefixPhoneType.slovenia;
      case 'unitedStates':
        return PrefixPhoneType.unitedStates;
      case 'estonia':
        return PrefixPhoneType.estonia;
      case 'eswatini':
        return PrefixPhoneType.eswatini;
      case 'ethiopia':
        return PrefixPhoneType.ethiopia;
      case 'philippines':
        return PrefixPhoneType.philippines;
      case 'fiji':
        return PrefixPhoneType.fiji;
      case 'gabon':
        return PrefixPhoneType.gabon;
      case 'gambia':
        return PrefixPhoneType.gambia;
      case 'georgia':
        return PrefixPhoneType.georgia;
      case 'ghana':
        return PrefixPhoneType.ghana;
      case 'grenada':
        return PrefixPhoneType.grenada;
      case 'greece':
        return PrefixPhoneType.greece;
      case 'guatemala':
        return PrefixPhoneType.guatemala;
      case 'guinea':
        return PrefixPhoneType.guinea;
      case 'equatorialGuinea':
        return PrefixPhoneType.equatorialGuinea;
      case 'guineaBissau':
        return PrefixPhoneType.guineaBissau;
      case 'guyana':
        return PrefixPhoneType.guyana;
      case 'haiti':
        return PrefixPhoneType.haiti;
      case 'honduras':
        return PrefixPhoneType.honduras;
      case 'hungary':
        return PrefixPhoneType.hungary;
      case 'india':
        return PrefixPhoneType.india;
      case 'indonesia':
        return PrefixPhoneType.indonesia;
      case 'iraq':
        return PrefixPhoneType.iraq;
      case 'ireland':
        return PrefixPhoneType.ireland;
      case 'iran':
        return PrefixPhoneType.iran;
      case 'iceland':
        return PrefixPhoneType.iceland;
      case 'marshallIslands':
        return PrefixPhoneType.marshallIslands;
      case 'solomonIslands':
        return PrefixPhoneType.solomonIslands;
      case 'israel':
        return PrefixPhoneType.israel;
      case 'jamaica':
        return PrefixPhoneType.jamaica;
      case 'japan':
        return PrefixPhoneType.japan;
      case 'jordan':
        return PrefixPhoneType.jordan;
      case 'kazakhstan':
        return PrefixPhoneType.kazakhstan;
      case 'kenya':
        return PrefixPhoneType.kenya;
      case 'kyrgyzstan':
        return PrefixPhoneType.kyrgyzstan;
      case 'kiribati':
        return PrefixPhoneType.kiribati;
      case 'kuwait':
        return PrefixPhoneType.kuwait;
      case 'laos':
        return PrefixPhoneType.laos;
      case 'lesotho':
        return PrefixPhoneType.lesotho;
      case 'latvia':
        return PrefixPhoneType.latvia;
      case 'liberia':
        return PrefixPhoneType.liberia;
      case 'libya':
        return PrefixPhoneType.libya;
      case 'liechtenstein':
        return PrefixPhoneType.liechtenstein;
      case 'lithuania':
        return PrefixPhoneType.lithuania;
      case 'luxembourg':
        return PrefixPhoneType.luxembourg;
      case 'lebanon':
        return PrefixPhoneType.lebanon;
      case 'madagascar':
        return PrefixPhoneType.madagascar;
      case 'malaysia':
        return PrefixPhoneType.malaysia;
      case 'malawi':
        return PrefixPhoneType.malawi;
      case 'maldives':
        return PrefixPhoneType.maldives;
      case 'malta':
        return PrefixPhoneType.malta;
      case 'mali':
        return PrefixPhoneType.mali;
      case 'morocco':
        return PrefixPhoneType.morocco;
      case 'mauritius':
        return PrefixPhoneType.mauritius;
      case 'mauritania':
        return PrefixPhoneType.mauritania;
      case 'micronesia':
        return PrefixPhoneType.micronesia;
      case 'moldova':
        return PrefixPhoneType.moldova;
      case 'mongolia':
        return PrefixPhoneType.mongolia;
      case 'montenegro':
        return PrefixPhoneType.montenegro;
      case 'mozambique':
        return PrefixPhoneType.mozambique;
      case 'mexico':
        return PrefixPhoneType.mexico;
      case 'monaco':
        return PrefixPhoneType.monaco;
      case 'namibia':
        return PrefixPhoneType.namibia;
      case 'nauru':
        return PrefixPhoneType.nauru;
      case 'nepal':
        return PrefixPhoneType.nepal;
      case 'nicaragua':
        return PrefixPhoneType.nicaragua;
      case 'nigeria':
        return PrefixPhoneType.nigeria;
      case 'newZealand':
        return PrefixPhoneType.newZealand;
      case 'niger':
        return PrefixPhoneType.niger;
      case 'oman':
        return PrefixPhoneType.oman;
      case 'pakistan':
        return PrefixPhoneType.pakistan;
      case 'palau':
        return PrefixPhoneType.palau;
      case 'panama':
        return PrefixPhoneType.panama;
      case 'papuaNewGuinea':
        return PrefixPhoneType.papuaNewGuinea;
      case 'paraguay':
        return PrefixPhoneType.paraguay;
      case 'netherlands':
        return PrefixPhoneType.netherlands;
      case 'peru':
        return PrefixPhoneType.peru;
      case 'poland':
        return PrefixPhoneType.poland;
      case 'centralAfricanRepublic':
        return PrefixPhoneType.centralAfricanRepublic;
      case 'czechRepublic':
        return PrefixPhoneType.czechRepublic;
      case 'democraticRepublicOfCongo':
        return PrefixPhoneType.democraticRepublicOfCongo;
      case 'dominicanRepublic':
        return PrefixPhoneType.dominicanRepublic;
      case 'republicOfCongo':
        return PrefixPhoneType.republicOfCongo;
      case 'rwanda':
        return PrefixPhoneType.rwanda;
      case 'romania':
        return PrefixPhoneType.romania;
      case 'russia':
        return PrefixPhoneType.russia;
      case 'samoa':
        return PrefixPhoneType.samoa;
      case 'saintKittsAndNevis':
        return PrefixPhoneType.saintKittsAndNevis;
      case 'sanMarino':
        return PrefixPhoneType.sanMarino;
      case 'saintVincentAndGrenadines':
        return PrefixPhoneType.saintVincentAndGrenadines;
      case 'saintLucia':
        return PrefixPhoneType.saintLucia;
      case 'saoTomeAndPrincipe':
        return PrefixPhoneType.saoTomeAndPrincipe;
      case 'senegal':
        return PrefixPhoneType.senegal;
      case 'serbia':
        return PrefixPhoneType.serbia;
      case 'seychelles':
        return PrefixPhoneType.seychelles;
      case 'sierraLeone':
        return PrefixPhoneType.sierraLeone;
      case 'singapore':
        return PrefixPhoneType.singapore;
      case 'syria':
        return PrefixPhoneType.syria;
      case 'somalia':
        return PrefixPhoneType.somalia;
      case 'sriLanka':
        return PrefixPhoneType.sriLanka;
      case 'southAfrica':
        return PrefixPhoneType.southAfrica;
      case 'sudan':
        return PrefixPhoneType.sudan;
      case 'southSudan':
        return PrefixPhoneType.southSudan;
      case 'switzerland':
        return PrefixPhoneType.switzerland;
      case 'suriname':
        return PrefixPhoneType.suriname;
      case 'thailand':
        return PrefixPhoneType.thailand;
      case 'tanzania':
        return PrefixPhoneType.tanzania;
      case 'tajikistan':
        return PrefixPhoneType.tajikistan;
      case 'eastTimor':
        return PrefixPhoneType.eastTimor;
      case 'togo':
        return PrefixPhoneType.togo;
      case 'tonga':
        return PrefixPhoneType.tonga;
      case 'trinidadAndTobago':
        return PrefixPhoneType.trinidadAndTobago;
      case 'turkmenistan':
        return PrefixPhoneType.turkmenistan;
      case 'turkey':
        return PrefixPhoneType.turkey;
      case 'tuvalu':
        return PrefixPhoneType.tuvalu;
      case 'tunisia':
        return PrefixPhoneType.tunisia;
      case 'ukraine':
        return PrefixPhoneType.ukraine;
      case 'uganda':
        return PrefixPhoneType.uganda;
      case 'uruguay':
        return PrefixPhoneType.uruguay;
      case 'uzbekistan':
        return PrefixPhoneType.uzbekistan;
      case 'vanuatu':
        return PrefixPhoneType.vanuatu;
      case 'venezuela':
        return PrefixPhoneType.venezuela;
      case 'vietnam':
        return PrefixPhoneType.vietnam;
      case 'yemen':
        return PrefixPhoneType.yemen;
      case 'djibouti':
        return PrefixPhoneType.djibouti;
      case 'zambia':
        return PrefixPhoneType.zambia;
      case 'zimbabwe':
        return PrefixPhoneType.zimbabwe;
      default:
        return PrefixPhoneType.spain;
    }
  }

  String toTranslate(BuildContext context) {
    switch (this) {
      case PrefixPhoneType.spain:
        return context.cl.translate('countries.ES');
      case PrefixPhoneType.germany:
        return context.cl.translate('countries.DE');
      case PrefixPhoneType.unitedKingdom:
        return context.cl.translate('countries.GB');
      case PrefixPhoneType.norway:
        return context.cl.translate('countries.NO');
      case PrefixPhoneType.sweden:
        return context.cl.translate('countries.SE');
      case PrefixPhoneType.finland:
        return context.cl.translate('countries.FI');
      case PrefixPhoneType.italy:
        return context.cl.translate('countries.IT');
      case PrefixPhoneType.portugal:
        return context.cl.translate('countries.PT');
      case PrefixPhoneType.france:
        return context.cl.translate('countries.FR');
      case PrefixPhoneType.afghanistan:
        return context.cl.translate('countries.AF');
      case PrefixPhoneType.albania:
        return context.cl.translate('countries.AL');
      case PrefixPhoneType.andorra:
        return context.cl.translate('countries.AD');
      case PrefixPhoneType.angola:
        return context.cl.translate('countries.AO');
      case PrefixPhoneType.antiguaAndBarbuda:
        return context.cl.translate('countries.AG');
      case PrefixPhoneType.saudiArabia:
        return context.cl.translate('countries.SA');
      case PrefixPhoneType.algeria:
        return context.cl.translate('countries.DZ');
      case PrefixPhoneType.argentina:
        return context.cl.translate('countries.AR');
      case PrefixPhoneType.armenia:
        return context.cl.translate('countries.AM');
      case PrefixPhoneType.australia:
        return context.cl.translate('countries.AU');
      case PrefixPhoneType.austria:
        return context.cl.translate('countries.AT');
      case PrefixPhoneType.azerbaijan:
        return context.cl.translate('countries.AZ');
      case PrefixPhoneType.bahamas:
        return context.cl.translate('countries.BS');
      case PrefixPhoneType.bangladesh:
        return context.cl.translate('countries.BD');
      case PrefixPhoneType.barbados:
        return context.cl.translate('countries.BB');
      case PrefixPhoneType.bahrain:
        return context.cl.translate('countries.BH');
      case PrefixPhoneType.belize:
        return context.cl.translate('countries.BZ');
      case PrefixPhoneType.benin:
        return context.cl.translate('countries.BJ');
      case PrefixPhoneType.belarus:
        return context.cl.translate('countries.BY');
      case PrefixPhoneType.myanmar:
        return context.cl.translate('countries.MM');
      case PrefixPhoneType.bolivia:
        return context.cl.translate('countries.BO');
      case PrefixPhoneType.bosniaAndHerzegovina:
        return context.cl.translate('countries.BA');
      case PrefixPhoneType.botswana:
        return context.cl.translate('countries.BW');
      case PrefixPhoneType.brazil:
        return context.cl.translate('countries.BR');
      case PrefixPhoneType.brunei:
        return context.cl.translate('countries.BN');
      case PrefixPhoneType.bulgaria:
        return context.cl.translate('countries.BG');
      case PrefixPhoneType.burkinaFaso:
        return context.cl.translate('countries.BF');
      case PrefixPhoneType.burundi:
        return context.cl.translate('countries.BI');
      case PrefixPhoneType.bhutan:
        return context.cl.translate('countries.BT');
      case PrefixPhoneType.belgium:
        return context.cl.translate('countries.BE');
      case PrefixPhoneType.capeVerde:
        return context.cl.translate('countries.CV');
      case PrefixPhoneType.cambodia:
        return context.cl.translate('countries.KH');
      case PrefixPhoneType.cameroon:
        return context.cl.translate('countries.CM');
      case PrefixPhoneType.canada:
        return context.cl.translate('countries.CA');
      case PrefixPhoneType.qatar:
        return context.cl.translate('countries.QA');
      case PrefixPhoneType.chad:
        return context.cl.translate('countries.TD');
      case PrefixPhoneType.chile:
        return context.cl.translate('countries.CL');
      case PrefixPhoneType.china:
        return context.cl.translate('countries.CN');
      case PrefixPhoneType.cyprus:
        return context.cl.translate('countries.CY');
      case PrefixPhoneType.vaticanCity:
        return context.cl.translate('countries.VA');
      case PrefixPhoneType.colombia:
        return context.cl.translate('countries.CO');
      case PrefixPhoneType.comoros:
        return context.cl.translate('countries.KM');
      case PrefixPhoneType.congo:
        return context.cl.translate('countries.CG');
      case PrefixPhoneType.northKorea:
        return context.cl.translate('countries.KP');
      case PrefixPhoneType.southKorea:
        return context.cl.translate('countries.KR');
      case PrefixPhoneType.costaRica:
        return context.cl.translate('countries.CR');
      case PrefixPhoneType.ivoryCoast:
        return context.cl.translate('countries.CI');
      case PrefixPhoneType.croatia:
        return context.cl.translate('countries.HR');
      case PrefixPhoneType.cuba:
        return context.cl.translate('countries.CU');
      case PrefixPhoneType.denmark:
        return context.cl.translate('countries.DK');
      case PrefixPhoneType.dominica:
        return context.cl.translate('countries.DM');
      case PrefixPhoneType.ecuador:
        return context.cl.translate('countries.EC');
      case PrefixPhoneType.egypt:
        return context.cl.translate('countries.EG');
      case PrefixPhoneType.elSalvador:
        return context.cl.translate('countries.SV');
      case PrefixPhoneType.unitedArabEmirates:
        return context.cl.translate('countries.AE');
      case PrefixPhoneType.eritrea:
        return context.cl.translate('countries.ER');
      case PrefixPhoneType.slovakia:
        return context.cl.translate('countries.SK');
      case PrefixPhoneType.slovenia:
        return context.cl.translate('countries.SI');
      case PrefixPhoneType.unitedStates:
        return context.cl.translate('countries.US');
      case PrefixPhoneType.estonia:
        return context.cl.translate('countries.EE');
      case PrefixPhoneType.eswatini:
        return context.cl.translate('countries.SZ');
      case PrefixPhoneType.ethiopia:
        return context.cl.translate('countries.ET');
      case PrefixPhoneType.philippines:
        return context.cl.translate('countries.PH');
      case PrefixPhoneType.fiji:
        return context.cl.translate('countries.FJ');
      case PrefixPhoneType.gabon:
        return context.cl.translate('countries.GA');
      case PrefixPhoneType.gambia:
        return context.cl.translate('countries.GM');
      case PrefixPhoneType.georgia:
        return context.cl.translate('countries.GE');
      case PrefixPhoneType.ghana:
        return context.cl.translate('countries.GH');
      case PrefixPhoneType.grenada:
        return context.cl.translate('countries.GD');
      case PrefixPhoneType.greece:
        return context.cl.translate('countries.GR');
      case PrefixPhoneType.guatemala:
        return context.cl.translate('countries.GT');
      case PrefixPhoneType.guinea:
        return context.cl.translate('countries.GN');
      case PrefixPhoneType.equatorialGuinea:
        return context.cl.translate('countries.GQ');
      case PrefixPhoneType.guineaBissau:
        return context.cl.translate('countries.GW');
      case PrefixPhoneType.guyana:
        return context.cl.translate('countries.GY');
      case PrefixPhoneType.haiti:
        return context.cl.translate('countries.HT');
      case PrefixPhoneType.honduras:
        return context.cl.translate('countries.HN');
      case PrefixPhoneType.hungary:
        return context.cl.translate('countries.HU');
      case PrefixPhoneType.india:
        return context.cl.translate('countries.IN');
      case PrefixPhoneType.indonesia:
        return context.cl.translate('countries.ID');
      case PrefixPhoneType.iraq:
        return context.cl.translate('countries.IQ');
      case PrefixPhoneType.ireland:
        return context.cl.translate('countries.IE');
      case PrefixPhoneType.iran:
        return context.cl.translate('countries.IR');
      case PrefixPhoneType.iceland:
        return context.cl.translate('countries.IS');
      case PrefixPhoneType.marshallIslands:
        return context.cl.translate('countries.MH');
      case PrefixPhoneType.solomonIslands:
        return context.cl.translate('countries.SB');
      case PrefixPhoneType.israel:
        return context.cl.translate('countries.IL');
      case PrefixPhoneType.jamaica:
        return context.cl.translate('countries.JM');
      case PrefixPhoneType.japan:
        return context.cl.translate('countries.JP');
      case PrefixPhoneType.jordan:
        return context.cl.translate('countries.JO');
      case PrefixPhoneType.kazakhstan:
        return context.cl.translate('countries.KZ');
      case PrefixPhoneType.kenya:
        return context.cl.translate('countries.KE');
      case PrefixPhoneType.kyrgyzstan:
        return context.cl.translate('countries.KG');
      case PrefixPhoneType.kiribati:
        return context.cl.translate('countries.KI');
      case PrefixPhoneType.kuwait:
        return context.cl.translate('countries.KW');
      case PrefixPhoneType.laos:
        return context.cl.translate('countries.LA');
      case PrefixPhoneType.lesotho:
        return context.cl.translate('countries.LS');
      case PrefixPhoneType.latvia:
        return context.cl.translate('countries.LV');
      case PrefixPhoneType.liberia:
        return context.cl.translate('countries.LR');
      case PrefixPhoneType.libya:
        return context.cl.translate('countries.LY');
      case PrefixPhoneType.liechtenstein:
        return context.cl.translate('countries.LI');
      case PrefixPhoneType.lithuania:
        return context.cl.translate('countries.LT');
      case PrefixPhoneType.luxembourg:
        return context.cl.translate('countries.LU');
      case PrefixPhoneType.lebanon:
        return context.cl.translate('countries.LB');
      case PrefixPhoneType.madagascar:
        return context.cl.translate('countries.MG');
      case PrefixPhoneType.malaysia:
        return context.cl.translate('countries.MY');
      case PrefixPhoneType.malawi:
        return context.cl.translate('countries.MW');
      case PrefixPhoneType.maldives:
        return context.cl.translate('countries.MV');
      case PrefixPhoneType.malta:
        return context.cl.translate('countries.MT');
      case PrefixPhoneType.mali:
        return context.cl.translate('countries.ML');
      case PrefixPhoneType.morocco:
        return context.cl.translate('countries.MA');
      case PrefixPhoneType.mauritius:
        return context.cl.translate('countries.MU');
      case PrefixPhoneType.mauritania:
        return context.cl.translate('countries.MR');
      case PrefixPhoneType.micronesia:
        return context.cl.translate('countries.FM');
      case PrefixPhoneType.moldova:
        return context.cl.translate('countries.MD');
      case PrefixPhoneType.mongolia:
        return context.cl.translate('countries.MN');
      case PrefixPhoneType.montenegro:
        return context.cl.translate('countries.ME');
      case PrefixPhoneType.mozambique:
        return context.cl.translate('countries.MZ');
      case PrefixPhoneType.mexico:
        return context.cl.translate('countries.MX');
      case PrefixPhoneType.monaco:
        return context.cl.translate('countries.MC');
      case PrefixPhoneType.namibia:
        return context.cl.translate('countries.NA');
      case PrefixPhoneType.nauru:
        return context.cl.translate('countries.NR');
      case PrefixPhoneType.nepal:
        return context.cl.translate('countries.NP');
      case PrefixPhoneType.nicaragua:
        return context.cl.translate('countries.NI');
      case PrefixPhoneType.nigeria:
        return context.cl.translate('countries.NG');
      case PrefixPhoneType.newZealand:
        return context.cl.translate('countries.NZ');
      case PrefixPhoneType.niger:
        return context.cl.translate('countries.NE');
      case PrefixPhoneType.oman:
        return context.cl.translate('countries.OM');
      case PrefixPhoneType.pakistan:
        return context.cl.translate('countries.PK');
      case PrefixPhoneType.palau:
        return context.cl.translate('countries.PW');
      case PrefixPhoneType.panama:
        return context.cl.translate('countries.PA');
      case PrefixPhoneType.papuaNewGuinea:
        return context.cl.translate('countries.PG');
      case PrefixPhoneType.paraguay:
        return context.cl.translate('countries.PY');
      case PrefixPhoneType.netherlands:
        return context.cl.translate('countries.NL');
      case PrefixPhoneType.peru:
        return context.cl.translate('countries.PE');
      case PrefixPhoneType.poland:
        return context.cl.translate('countries.PL');
      case PrefixPhoneType.centralAfricanRepublic:
        return context.cl.translate('countries.CF');
      case PrefixPhoneType.czechRepublic:
        return context.cl.translate('countries.CZ');
      case PrefixPhoneType.democraticRepublicOfCongo:
        return context.cl.translate('countries.CD');
      case PrefixPhoneType.dominicanRepublic:
        return context.cl.translate('countries.DO');
      case PrefixPhoneType.republicOfCongo:
        return context.cl.translate('countries.RC');
      case PrefixPhoneType.rwanda:
        return context.cl.translate('countries.RW');
      case PrefixPhoneType.romania:
        return context.cl.translate('countries.RO');
      case PrefixPhoneType.russia:
        return context.cl.translate('countries.RU');
      case PrefixPhoneType.samoa:
        return context.cl.translate('countries.WS');
      case PrefixPhoneType.saintKittsAndNevis:
        return context.cl.translate('countries.KN');
      case PrefixPhoneType.sanMarino:
        return context.cl.translate('countries.SM');
      case PrefixPhoneType.saintVincentAndGrenadines:
        return context.cl.translate('countries.VC');
      case PrefixPhoneType.saintLucia:
        return context.cl.translate('countries.LC');
      case PrefixPhoneType.saoTomeAndPrincipe:
        return context.cl.translate('countries.ST');
      case PrefixPhoneType.senegal:
        return context.cl.translate('countries.SN');
      case PrefixPhoneType.serbia:
        return context.cl.translate('countries.RS');
      case PrefixPhoneType.seychelles:
        return context.cl.translate('countries.SC');
      case PrefixPhoneType.sierraLeone:
        return context.cl.translate('countries.SL');
      case PrefixPhoneType.singapore:
        return context.cl.translate('countries.SG');
      case PrefixPhoneType.syria:
        return context.cl.translate('countries.SY');
      case PrefixPhoneType.somalia:
        return context.cl.translate('countries.SO');
      case PrefixPhoneType.sriLanka:
        return context.cl.translate('countries.LK');
      case PrefixPhoneType.southAfrica:
        return context.cl.translate('countries.ZA');
      case PrefixPhoneType.sudan:
        return context.cl.translate('countries.SD');
      case PrefixPhoneType.southSudan:
        return context.cl.translate('countries.SS');
      case PrefixPhoneType.switzerland:
        return context.cl.translate('countries.CH');
      case PrefixPhoneType.suriname:
        return context.cl.translate('countries.SR');
      case PrefixPhoneType.thailand:
        return context.cl.translate('countries.TH');
      case PrefixPhoneType.tanzania:
        return context.cl.translate('countries.TZ');
      case PrefixPhoneType.tajikistan:
        return context.cl.translate('countries.TJ');
      case PrefixPhoneType.eastTimor:
        return context.cl.translate('countries.TL');
      case PrefixPhoneType.togo:
        return context.cl.translate('countries.TG');
      case PrefixPhoneType.tonga:
        return context.cl.translate('countries.TO');
      case PrefixPhoneType.trinidadAndTobago:
        return context.cl.translate('countries.TT');
      case PrefixPhoneType.turkmenistan:
        return context.cl.translate('countries.TM');
      case PrefixPhoneType.turkey:
        return context.cl.translate('countries.TR');
      case PrefixPhoneType.tuvalu:
        return context.cl.translate('countries.TV');
      case PrefixPhoneType.tunisia:
        return context.cl.translate('countries.TN');
      case PrefixPhoneType.ukraine:
        return context.cl.translate('countries.UA');
      case PrefixPhoneType.uganda:
        return context.cl.translate('countries.UG');
      case PrefixPhoneType.uruguay:
        return context.cl.translate('countries.UY');
      case PrefixPhoneType.uzbekistan:
        return context.cl.translate('countries.UZ');
      case PrefixPhoneType.vanuatu:
        return context.cl.translate('countries.VU');
      case PrefixPhoneType.venezuela:
        return context.cl.translate('countries.VE');
      case PrefixPhoneType.vietnam:
        return context.cl.translate('countries.VN');
      case PrefixPhoneType.yemen:
        return context.cl.translate('countries.YE');
      case PrefixPhoneType.djibouti:
        return context.cl.translate('countries.DJ');
      case PrefixPhoneType.zambia:
        return context.cl.translate('countries.ZM');
      case PrefixPhoneType.zimbabwe:
        return context.cl.translate('countries.ZW');
    }
  }
}
