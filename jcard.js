// JavaScript Document

//RFC 6350 
/*
VERSION AND FN REQUIRED
*/
//CARD
var jcard1 =["vcardstream",["vcard",[
		["version",{},"text","4.0"],
		["fn",{},"text","DR. Bobby Forrest Gump , Esq."],
		["kind",{},"text","individual"]
		["uid",{},"urn","uuid:da418720-3754-4631-a169-db89a02b831b"]
]]]
var jcard2 =["vcardstream",["vcard",[
		["version",{},"text","4.0"],
		["fn",{},"text","DR. Bobby Forrest Gump , Esq."],
		["kind",{},"text","organization"],
		["uid",{},"urn","uuid:da418720-3754-4631-a169-db89a02b832b"]
]]]

//GROUP
var jcard3 =["vcardstream",["vcard",[
		["version",{},"text","4.0"],
		["fn",{},"text","Enterprise Group"],
		["kind",{},"text","group"],
		["member",{},"text","mailto:abuse@example.org"],
		["uid",{},"urn","uuid:da418720-3754-4631-a169-db89a02b833b"]
]]]
var jcarddesc = [
    "vcardstream",
    [
        "vcard",
        [
		
		/*
	ADR RFC 6350.6.3.1 (MULTI FIELDS FREE TEXT)
	 	The structured type value consists of a sequence of
      	address components.  The component values MUST be specified in
      	their corresponding position.  The structured type value
      	corresponds, in sequence, to
         the post office box;
         the extended address (e.g., apartment or suite number);
         the street address;
         the locality (e.g., city);
         the region (e.g., state or province);
         the postal code;
         the country name (full name in the language specified in
         Section 5.1).
		 
		 Parms: LABEL
		*/
            ["adr",{"label": "100 Waters Edge\nBaytown, LA 30314\nUnited States of America","type": "work"},
                "text",["","","100 Waters Edge","Baytown","LA","30314","United States of America"]
			],
            ["adr",{"label": "42 Plantation St.\nBaytown, LA 30314\nUnited States of America","type": "home"},
                "text",["","","42 Plantation St.","Baytown","LA","30314","United States of America"]
            ],
		/*
	ANNIVERSARY RFC 6350 6.2.6 (DATE TIME)
		date-and-or-time, date-time 
		*/
			["anniversary",{},"date-time","2013-01-10T19:00:00Z"],
			["bday",{},"date-and-or-time","2013-02-14T12:30:00"],
			["caladruri",{},"uri","http://www.viagenie.ca/simon.perreault/simon"],
			["caluri",{},"uri","http://www.viagenie.ca/simon.perreault/simon"],
			
	/*
	CATEGORIES RFC 6350 6.7.1 (DROP DOWN)
	CATEGORIES:INTERNET,IETF,INDUSTRY,INFORMATION TECHNOLOGY
	*/
            ["categories",{},"text","computers","cameras"],			
			["clientpidmap",{},"text","urn","uuid:3df403f4-5924-4bb7-b077-3c711d9eb34b"],	
			["email",{"type": "work"},"text","simon.perreault@viagenie.ca"],			
			["fburl",{"type": "work"},"uri","fburl:http://www.viagenie.ca/simon.perreault/simon.html"],
			["fn",{"group": "CONTACT"},"text","DR. Bobby Forrest Gump , Esq."],
			
		/*
	GENDER RFC 6350 6.2.7. (DROP DOWN)
		Sex component:  A single letter.  M stands for "male", F stands
        for "female", O stands for "other", N stands for "none or not
        applicable", U stands for "unknown". 
		
		Can contain free text GENDER:F;Grrrl (keep it simple drop down)
		Can be empty
		 */
			["gender",{},"text",["F"]],
		/*
	GEO RFC 6350 6.5.2 (MAP TO HIDDEN FIELD)
	https://developers.google.com/maps/articles/geolocation
		*/
			["geo",{"type": "work"},"uri","geo:46.772673,-71.282945"],
			["impp",{"type":"personal"},"im","alice@example.com"],
			["key",{"type": "work"},"uri","http://www.viagenie.ca/simon.perreault/simon.asc"],
			["kind",{},"text","individual"],
				["kind",{},"text","organization"],
				["kind",{},"text","group"],
			["lang",{},"language-tag","en"],
		/*
	LOGO RFC 6350 6.6.3 (DO NOT USE - USE PHOTO)
		*/
			["logo",{"mediatype": "image/gif"},"uri","http://www.example.com/dir_photos/my_photo.gif"],
		/*
	MEMBER RFC 6350 6.6.5 ()
	*USE WITH GROUP*
	 	BEGIN:VCARD
     	VERSION:4.0
    	KIND:group
     	FN:Funky distribution list
     	MEMBER:mailto:subscriber1@example.com
     	END:VCARD
		*/			
			["member",{},"text","mailto:abuse@example.org"],
			
		/*
	N RFC 6350.6.2.2 (FREE TEXT)
		The structured property value corresponds, in
      	sequence, to the Family Names (also known as surnames), Given
      	Names, Additional Names, Honorific Prefixes, and Honorific
      	Suffixes.  The text components are separated by the SEMICOLON
      	character (U+003B).  Individual text components can include
      	multiple text values separated by the COMMA character (U+002C).
		
		Params: SORT-AS
		*/
			["n",{"sort-as":""},"text",["SURNAMES","GIVEN NAME","ADDITIONAL NAMES","HONORIFIC PREFIXES","HONORIFIC SUFFIXES"]],
			
			["nickname",{},"text","bo-bo"],
		/*	
	NOTE RFC 6.7.2 (FREE TEXT)
		Purpose:  To specify supplemental information or a comment that is
      	associated with the vCard.
		*/ 
			["note",{},"text","hello world"],
			
		/*
	ORG RFC 6350.6.2.2 (FREE TEXT)
		Params: SORT-AS
		*/	
			["org",{},"text","Bubba Gump Shrimp Co"],
		
			["photo",{"mediatype": "image/gif"},"uri","http://www.example.com/dir_photos/my_photo.gif"],
			
		/*
	PRODID RFC 6.7.3 (HIDDEN)
	   	Purpose:  To specify the identifier for the product that created the
      	vCard object.
		
		PRODID:-//ONLINE DIRECTORY//NONSGML Version 1//EN
		*/	
			["prodid",{},"text","OpenContact"],
			
		/*
	RELATED	RFC 6350 6.6.6 (TYPE: DROPDOWN)
		TYPE:contact,co-worker,neighbor,sibling,emergency
		URN: contact uuid
		*/
			["related",{"type":"friend"},"urn","uuid:03a0e51f-d1aa-4385-8a53-e29025acd8af"],
			["rev",{},"timestamp","2013-02-14T12:30:00Z"],
			
		/*
	ROLE RFC 6350 6.6.2 (FREE TEXT)
		
		*/
			["role",{},"text","Executive"],
			["sound",{"mediatype":"audio/ogg"},"uri","http://example.com"],
			["source",{},"uri","http://johndoe.com/vcard.vcf"],
			
		/*
	TEL RFC 6350.6.2.2 (FREE TEXT)
	type: (work, home) and (text,voice,fax,cell,video,pager,textphone), uri type tel
		*/
            ["tel",{"type": ["work","voice"]},"uri","tel:+1-111-555-1212"],
            ["tel",{"type": ["home","voice"],"ext":""},"uri","tel:+1-404-555-1212"],		
			
		/*
	TITLE RFC 6350.6.2.1 (FREE TEXT)
		*/			
            ["title",{},"text","Shrimp Man"],	
		/*
	TZ RFC 6350.6.5.1 (DROP DOWN from TZ-DB)
		http://www.iana.org/time-zones
		ftp://ftp.iana.org/tz/data/zone.tab
		*/
            ["tz",{},"utc-offset","-05:00"],	
			["uid",{},"urn","uuid:da418720-3754-4631-a169-db89a02b831b"],
			["url",{"type": "home"},"uri","http://nomis80.org"],
            ["version",{},"text","4.0"],			
			
			["birthplace",{},"text","Maida Vale, London"],
			["deathdate",{},"date-time","2013-01-10T19:00:00Z"],
			["deathplace",{},"uri","geo:46.772673,-71.282945"],
            ["expertise",{"level":"expert"},"text","Computer Science"],	
			["hobby",{"level":"expert"},"text","Knitting"],	
            ["interest",{"level":"high"},"text","baseball"],	
			["org-directory",{},"uri","http://www.company.com/employees"],	
			
 
        ]
    ]
]

