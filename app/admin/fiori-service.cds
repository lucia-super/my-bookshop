using { AdminService } from '../../db/schema';

////////////////////////////////////////////////////////////////////////////
//
//	Books Object Page
//

annotate AdminService.Books with @(
	UI: {
        SelectionFields: [ createdAt, createdBy ],
        LineItem: [
			{Value: title},
            {Value: author, Label:'{i18n>Author}'},
            {Value: genre.name},
            {Value: price},
            {Value: currency.symbol, Label:' '},
		],
        HeaderInfo: {
            Initials: 'no data',
			TypeName: 'Book', TypeNamePlural: 'Books',
		},
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>General}', Target: '@UI.FieldGroup#General'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Translations}', Target:  'texts/@UI.LineItem'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Details}', Target: '@UI.FieldGroup#Details'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Admin}', Target: '@UI.FieldGroup#Admin'},
		],
		FieldGroup#General: {
			Data: [
				{Value: title},
				{Value: author_ID},
				{Value: genre_ID},
				{Value: descr},
			]
		},
		FieldGroup#Details: {
			Data: [
				{Value: stock},
				{Value: price},
				{Value: currency_code, Label: '{i18n>Currency}'},
			]
		},
		FieldGroup#Admin: {
			Data: [
				{Value: createdBy},
				{Value: createdAt},
				{Value: modifiedBy},
				{Value: modifiedAt}
			]
		}
	}
){
	createdAt @UI.HiddenFilter:true;
	createdBy @UI.HiddenFilter:false;
};

annotate AdminService.Authors with @(
	UI: {
		HeaderInfo: {
			Description: {Value: lifetime}
		},
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Details}', Target: '@UI.FieldGroup#Details'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Books}', Target: 'books/@UI.LineItem'},
		],
		FieldGroup#Details: {
			Data: [
				{Value: placeOfBirth},
				{Value: placeOfDeath},
				{Value: dateOfBirth},
				{Value: dateOfDeath},
				{Value: age, Label: '{i18n>Age}'},
			]
		},
	}
);


////////////////////////////////////////////////////////////
//
//  Draft for Localized Data
//

annotate sap.capire.bookshop.Books with @fiori.draft.enabled;
annotate AdminService.Books with @odata.draft.enabled;

annotate AdminService.Books.texts with @(
	UI: {
		Identification: [
            {Value:title, Label: '{i18n>Title}'}, 
            {Value:descr, Label: '{i18n>Description}'}, 
            {Value:stock, Label: '{i18n>Stock}'}
        ],
		SelectionFields: [ locale, title ],
		LineItem: [
			{Value: locale, Label: 'Locale'},
			{Value: title, Label: 'Title'},
			{Value: descr, Label: 'Description'},
			{Value: stock, Label: 'Stock'},
		]
	}
);

// // Add Value Help for Locales
// annotate AdminService.Books.texts {
// 	locale @ValueList:{entity:'Languages',type:#fixed}
// }
// In addition we need to expose Languages through AdminService
using { sap } from '@sap/cds/common';
extend service AdminService {
	entity Languages as projection on sap.common.Languages;
}
