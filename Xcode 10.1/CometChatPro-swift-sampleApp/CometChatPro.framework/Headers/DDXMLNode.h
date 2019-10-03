#import <Foundation/Foundation.h>
#import <libxml/tree.h>
@class DDXMLDocument;

/**
 * Welcome to KissXML.
 * 
 * The project page has documentation if you have questions.
 * https://github.com/robbiehanson/KissXML
 * 
 * If you're new to the project you may wish to read the "Getting Started" wiki.
 * https://github.com/robbiehanson/KissXML/wiki/GettingStarted
 * 
 * KissXML provides a drop-in replacement for Apple's NSXML class cluster.
 * The goal is to get the exact same behavior as the NSXML classes.
 * 
 * For API Reference, see Apple's excellent documentation,
 * either via Xcode's Mac OS X documentation, or via the web:
 * 
 * https://github.com/robbiehanson/KissXML/wiki/Reference
**/

enum {
	DDXMLInvalidKind NS_SWIFT_NAME(XMLInvalidKind)                = 0,
	DDXMLDocumentKind NS_SWIFT_NAME(XMLDocumentKind),
	DDXMLElementKind NS_SWIFT_NAME(XMLElementKind),
	DDXMLAttributeKind NS_SWIFT_NAME(XMLAttributeKind),
	DDXMLNamespaceKind NS_SWIFT_NAME(XMLNamespaceKind),
	DDXMLProcessingInstructionKind NS_SWIFT_NAME(XMLProcessingInstructionKind),
	DDXMLCommentKind NS_SWIFT_NAME(XMLCommentKind),
	DDXMLTextKind NS_SWIFT_NAME(XMLTextKind),
	DDXMLDTDKind NS_SWIFT_NAME(XMLDTDKind),
	DDXMLEntityDeclarationKind NS_SWIFT_NAME(XMLEntityDeclarationKind),
	DDXMLAttributeDeclarationKind NS_SWIFT_NAME(XMLAttributeDeclarationKind),
	DDXMLElementDeclarationKind NS_SWIFT_NAME(XMLElementDeclarationKind),
	DDXMLNotationDeclarationKind NS_SWIFT_NAME(XMLNotationDeclarationKind)
};
typedef NSUInteger DDXMLNodeKind NS_SWIFT_NAME(XMLNodeKind);

enum {
	DDXMLNodeOptionsNone NS_SWIFT_NAME(XMLNodeOptionsNone)                  = 0,
	DDXMLNodeExpandEmptyElement NS_SWIFT_NAME(XMLNodeExpandEmptyElement)    = 1 << 1,
	DDXMLNodeCompactEmptyElement NS_SWIFT_NAME(XMLNodeCompactEmptyElement)  = 1 << 2,
	DDXMLNodePrettyPrint NS_SWIFT_NAME(XMLNodePrettyPrint)                  = 1 << 17,
};


NS_ASSUME_NONNULL_BEGIN
@interface DDXMLNode : NSObject <NSCopying>


//- (id)initWithKind:(DDXMLNodeKind)kind;

//- (id)initWithKind:(DDXMLNodeKind)kind options:(NSUInteger)options;

//+ (id)document;

//+ (id)documentWithRootElement:(DDXMLElement *)element;

+ (id)elementWithName:(NSString *)name;

+ (id)elementWithName:(NSString *)name URI:(NSString *)URI;

+ (id)elementWithName:(NSString *)name stringValue:(NSString *)string;

+ (id)elementWithName:(NSString *)name children:(NSArray *)children attributes:(NSArray *)attributes;

+ (id)attributeWithName:(NSString *)name stringValue:(NSString *)stringValue;

+ (id)attributeWithName:(NSString *)name URI:(NSString *)URI stringValue:(NSString *)stringValue;

+ (id)namespaceWithName:(NSString *)name stringValue:(NSString *)stringValue;

+ (id)processingInstructionWithName:(NSString *)name stringValue:(NSString *)stringValue;

+ (id)commentWithStringValue:(NSString *)stringValue;

+ (id)textWithStringValue:(NSString *)stringValue;

//+ (id)DTDNodeWithXMLString:(NSString *)string;

#pragma mark --- Properties ---

- (DDXMLNodeKind)kind;

- (void)setName:(NSString *)name;
- (NSString *)name;

//- (void)setObjectValue:(id)value;
//- (id)objectValue;

- (void)setStringValue:(NSString *)string;
//- (void)setStringValue:(NSString *)string resolvingEntities:(BOOL)resolve;
- (NSString *)stringValue;

#pragma mark --- Tree Navigation ---

- (NSUInteger)index;

- (NSUInteger)level;

- (DDXMLDocument *)rootDocument;

- (DDXMLNode *)parent;
- (NSUInteger)childCount;
- (NSArray *)children;
- (DDXMLNode *)childAtIndex:(NSUInteger)index;

- (DDXMLNode *)previousSibling;
- (DDXMLNode *)nextSibling;

- (DDXMLNode *)previousNode;
- (DDXMLNode *)nextNode;

- (void)detach;

- (NSString *)XPath;

#pragma mark --- QNames ---

- (NSString *)localName;
- (NSString *)prefix;

- (void)setURI:(NSString *)URI;
- (NSString *)URI;

+ (NSString *)localNameForName:(NSString *)name;
+ (NSString *)prefixForName:(NSString *)name;
//+ (DDXMLNode *)predefinedNamespaceForPrefix:(NSString *)name;

#pragma mark --- Output ---

- (NSString *)description;
- (NSString *)XMLString;
- (NSString *)XMLStringWithOptions:(NSUInteger)options;
//- (NSString *)canonicalXMLStringPreservingComments:(BOOL)comments;

#pragma mark --- XPath/XQuery ---

- (NSArray *)nodesForXPath:(NSString *)xpath error:(NSError **)error;
//- (NSArray *)objectsForXQuery:(NSString *)xquery constants:(NSDictionary *)constants error:(NSError **)error;
//- (NSArray *)objectsForXQuery:(NSString *)xquery error:(NSError **)error;
NS_ASSUME_NONNULL_END
@end
