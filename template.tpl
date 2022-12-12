___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Unique ID Generator",
  "description": "Generates a random ID based on different options, which you can use e.g. for the Client ID in Server Tags.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "RADIO",
    "name": "options",
    "displayName": "Please choose one of the options.",
    "radioItems": [
      {
        "value": "default",
        "displayValue": "Use default generated value.",
        "help": "This will generate an ID in following format: \"J90v-Aap9-9LXg-gKVm-UBe9\""
      },
      {
        "value": "custom",
        "displayValue": "Customize value for Client ID."
      }
    ],
    "simpleValueType": true,
    "defaultValue": "default"
  },
  {
    "type": "GROUP",
    "name": "customFields",
    "displayName": "",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "SELECT",
        "name": "characterLength",
        "displayName": "Please choose character length.",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": 16,
            "displayValue": "16 character"
          },
          {
            "value": 24,
            "displayValue": "24 character"
          },
          {
            "value": 32,
            "displayValue": "32 character"
          }
        ],
        "simpleValueType": true,
        "help": "You can choose between a length of 16, 24 or 32 character (excl. separators).",
        "alwaysInSummary": true
      },
      {
        "type": "SELECT",
        "name": "separator",
        "displayName": "Type of separator.",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "-",
            "displayValue": "Minus"
          },
          {
            "value": ".",
            "displayValue": "Dot"
          },
          {
            "value": "",
            "displayValue": "None"
          }
        ],
        "simpleValueType": true,
        "alwaysInSummary": true
      },
      {
        "type": "GROUP",
        "name": "chars",
        "displayName": "Select which characters to include.",
        "subParams": [
          {
            "type": "CHECKBOX",
            "name": "alphaUpper",
            "checkboxText": "Include uppercase letters",
            "simpleValueType": true,
            "valueValidators": []
          },
          {
            "type": "CHECKBOX",
            "name": "alphaLower",
            "checkboxText": "Include lowercase letters",
            "simpleValueType": true
          },
          {
            "type": "CHECKBOX",
            "name": "numbers",
            "checkboxText": "Include numbers",
            "simpleValueType": true
          }
        ],
        "groupStyle": "NO_ZIPPY",
        "help": "If nothing is selected, all characters will be included per default."
      }
    ],
    "enablingConditions": [
      {
        "paramName": "options",
        "paramValue": "custom",
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

const generateRandom = require('generateRandom');

const alphabeticCharUpper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const alphabeticCharLower = 'abcdefghijklmnopqrstuvwxyz';
const nums = '0123456789';
const userSeparator = data.options === 'default' ? '-' : (data.separator === 'none' ? '' : data.separator);

let characters = '';

if (data.alphaUpper) {
  characters += alphabeticCharUpper;
}

if (data.alphaLower) {
  characters += alphabeticCharLower;
}

if (data.numbers) {
  characters += nums;
}

if(!data.alphaUpper && !data.alphaLower && !data.numbers) {
  characters += alphabeticCharUpper + alphabeticCharLower + nums; 
}

const separatorIndices = () => {
  if(data.characterLength === 16) {
   return [2,6,8,12]; 
  }
  if (data.characterLength === 24) {
   return [4,8,12,18]; 
  }
  if (data.characterLength === 32) {
    return [8,12,16,20];
  }
  
};

const randomElement = (arr) => {
  return arr[generateRandom(0, arr.length - 1)];
};

const separator = userSeparator;
const characterLength = data.characterLength || 32;

const randomIdGenerator = () => {
  
  const charactersArr = characters.split('');
  let clientIdPlain = '';
  const indices = separatorIndices() || [8,12,16,20];
  
  for (let i = 0; i < characterLength; i++) {
    clientIdPlain += randomElement(charactersArr);
  }
  
  var clientIdCustom = clientIdPlain.split('');
  indices.reverse().forEach(i => clientIdCustom.splice(i,0,separator));
  return clientIdCustom.join('');
  
};

const final = randomIdGenerator();
return final;


___TESTS___

scenarios: []


___NOTES___

Created on 12.12.2022, 14:19:35


