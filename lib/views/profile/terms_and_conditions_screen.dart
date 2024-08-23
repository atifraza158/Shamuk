import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';

class TermsAndCondtionScreen extends StatefulWidget {
  const TermsAndCondtionScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndCondtionScreen> createState() => _TermsAndCondtionScreenState();
}

class _TermsAndCondtionScreenState extends State<TermsAndCondtionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themewhitecolor,
        appBar: AppBar(
          backgroundColor: Palette.themecolor,
          elevation: 0,
          title: const Text(
            "Terms & Condition",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "ACCEPTANCE",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    """SHAMUK is the leading platform for Home Construction and Renovation , providing an all-in-one software solution for industry professionals and tools for homeowners to update their homes from start to finish. Using Shamuk , people can find ideas and inspiration, hire professionals, and shop for products. As part of the SHAMUK platform, Provides home industry professionals with a business management and marketing that helps them to win projects, collaborate with clients and teams, and run their business efficiently and profitably.

The Website and the Service are provided to you subject to these Shamuk Terms of Use (these "Terms"). For the purpose of the Terms and wherever the context so requires, the terms 'you' and “your” shall mean any person who uses the Website or the Service in any manner whatsoever including persons browsing the Website and its content, posting comments or any content or responding to any advertisements or content on the Website. By accessing, browsing or using the Website or Service, you agree to comply with these Terms. Additionally, when using a portion of the Service, you agree to conform to any applicable posted guidelines for such Service, which may change or be updated from time to time at Shamuk's sole discretion. You understand and agree that you are solely responsible for reviewing these Terms from time to time. Should you object to any term or condition of these Terms, any guideline, or any subsequent changes thereto or become unhappy with Shamuk or the Service in any way, your only choice is to immediately discontinue use of Shamuk . These Terms may be updated by Shamuk at any time at its sole discretion. OLX may provide a translation of the English version of the Terms into other languages. You understand and agree that any translation of the Terms into other languages is for your convenience only and that the English version governs the terms of your relationship with SHAMUK . Furthermore, if there are any inconsistencies between the English version of the Terms and any translation, the English version of the Terms shall govern.
                  """,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: themegreytextcolor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "DESCRIPTION OF SERVICE AND CONTENT POLICY",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    """SHAMUK is the next generation of free online classifieds. We act as an online marketplace platform to allow our users who comply with these Terms to offer, sell, and buy products and services listed on the Website. Although you may be able to conduct payment and other transactions through the Website, using third-party vendors such as Easypaisa & JazzCash, S is not in any way involved in such transactions. As a result, and as discussed in more detail in these Terms, you hereby acknowledge and agree that SHAMUK is not a party to such transactions, has no control over any element of such transactions, and shall have no liability to any party in connection with such transactions. You use the Service and the Website at your own risk.

You understand that Shamuk does not control, and is not responsible for ads, directory information, business listings/information, messages between users, including without limitation e-mails sent from outside SHAMUK’s domain or other means of electronic communication, whether through the Website or another Third Party Website (defined below) or offerings, comments, user postings, files, images, photos, video, sounds, business listings/information and directory information or any other material made available through the Website and the Service ("Content"), and that by using the Website and the Service, you may be exposed to Content that is offensive, indecent, inaccurate, misleading, or otherwise objectionable. You acknowledge and agree that you are responsible for and must evaluate, and bear all risks associated with, the use of any Content, that you may not rely on said Content, and that under no circumstances will SHAMUK be liable in any way for the Content or for any loss or damage of any kind incurred as a result of the browsing, using or reading any Content listed, e-mailed or otherwise made available via the Service. You acknowledge and agree that SHAMUK permits such goods and services to be displayed and offered on the Website that conform with the terms stated herein, however SHAMUK does not pre-screen or approve any Content, but that SHAMUK has the right, in its sole and absolute discretion, to refuse, delete or move any Content that is or may be available through the Service, for violating these Terms and such violation being brought to SHAMUK’s knowledge or for any other reason or no reason at all. Furthermore, the Website and Content available through the Website may contain links to other third party websites ("Third Party Websites"), which are completely unrelated to SHAMUK . If you link to Third Party Websites, you may be subject to those Third Party Websites’ terms and conditions and other policies. SHAMUK makes no representation or guarantee as to the accuracy or authenticity of the information contained in any such Third Party Website, and your linking to any other websites is completely at your own risk and SHAMUK disclaims all liability thereto.

You acknowledge and agree that you are solely responsible for your own Content posted on, transmitted through, or linked from the Service and the consequences of posting, transmitting, linking or publishing it. More specifically, you are solely responsible for all Content that you upload, email or otherwise make available via the Service. In connection with such Content posted on, transmitted through, or linked from the Service by you, you affirm, acknowledge, represent, warrant and covenant that: i) you have developed the contents such as description and/or photographs in accordance with the instructions and guidance for placing an ad provided by SHAMUK on the website and that any copyrights therein belongs to SHAMUK and, to any extent, should you be deemed to own any copyright you hereby assign any such copyright to SHAMUK . ii) you acknowledge that the information and/or photographs that you post on the Website is stored and compiled by SHAMUK in a proprietary database and that the uploaded information and/or photographs are modified by SHAMUK by applying a watermark of SHAMUK logo and in such derivate works also the copyright belongs to SHAMUK. iii) you shall continue to, for such time the Content is available on the Website, have the necessary licenses, authorizations, consents, and permissions to use such Content on the Service and Website (including without limitation all patent, trademark, trade secret, copyright or other proprietary rights in and to any and all such Content) and wherever required, in such cases where you have the right, hereby authorize and license SHAMUK to exclusively use such Content to enable inclusion and use of the Content in the manner contemplated by the Service, the Website and these Terms; and iv) you have the written consent, release, and/or permission of each and every identifiable individual person or business in the Content to use the name or likeness of each and every such identifiable individual person or business to enable inclusion and use of the Content in the manner contemplated by the Service, the Website and these Terms. For clarity, by submitting any Content on the Website, as aforesaid, wherever you retain any ownership rights in the Content, you hereby grant to SHAMUK an irrevocable, non-cancellable, perpetual, worldwide, exclusive, royalty-free, sub-licensable, transferable license to use, reproduce, distribute, prepare derivative works of, display, and perform the Content in connection with the Website and SHAMUK's (and its successors') business, including without limitation for the purpose of promoting and redistributing part or all of the Website and Content therein (and derivative works thereof) in any media formats and through any media channels now or hereafter known. Furthermore, by you posting Content to any public area of the Service, to the extent you retain any ownership of any rights, you agree to and do hereby grant to OLX all exclusive rights necessary to prohibit or allow any subsequent aggregation, display, copying, duplication, reproduction, or exploitation of the Content on the Service or Website by any party for any purpose including the right to initiate legal action in accordance with the copyright and other laws of Pakistan. You also hereby grant each user of the Website a non-exclusive license to access your Content through the Website. The foregoing license to each user granted by you terminates once you or SHAMUK remove or delete such Content from the Website.

SHAMUK does not endorse any Content or any opinion, statement, recommendation, or advice expressed therein, and SHAMUK expressly disclaims any and all liability in connection with user Content. SHAMUK does not permit copyright infringing activities and infringement of intellectual property rights on the Website, and SHAMUK may, at its sole discretion, remove any infringing Content if properly notified in accordance with applicable law that such Content infringes on another's intellectual property rights. SHAMUK reserves the right to remove any Content without prior notice.SHAMUK may also terminate a user's access to the Website, if they are determined to be a repeat infringer or found to be indulging in any act contrary to these Terms. A repeat infringer is a user who has been notified of infringing activity more than twice and/or has had a user submission removed from the Website more than twice. Further, at its sole discretion, SHAMUK reserves the right to decide whether any Content is appropriate and complies with these Terms.""",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: themegreytextcolor,
                      fontSize: 14,
                    ),
                  ),
                   SizedBox(height: 10,),
                  Text(
                    "CONDUCT",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    """You agree not to post, email, host, display, upload, modify, publish, transmit, update or share any information on the Site, or otherwise make available Content:

that violates any law or regulation;

that is copyrighted or patented, protected by trade secret or trademark, or otherwise subject to third party other intellectual property or proprietary rights, including privacy and publicity rights, unless you are the owner of such rights or have permission or a license from their rightful owner to post the material and to grant SHAMUK all of the license rights granted herein;

that infringes any of the foregoing intellectual property rights of any party, or is Content that you do not have a right to make available under any law, regulation, contractual or fiduciary relationship(s);

that is harmful, abusive, unlawful, threatening, harassing, blasphemous, defamatory, obscene, pornographic, pedophilic, libelous, invasive of another's privacy or other rights, hateful, or racially, ethnically objectionable, disparaging, relating or encouraging money laundering or illegal gambling or harms or could harm minors in any way or otherwise unlawful in any manner whatsoever;

that harasses, degrades, intimidates or is hateful towards any individual or group of individuals on the basis of religion, gender, sexual orientation, race, ethnicity, age, or disability;

that violates any (local) equal employment laws, including but not limited to those prohibiting the stating, in any advertisement for employment, a preference or requirement based on race, color, religion, sex, national origin, age, or disability of the applicant.

that includes personal or identifying information about another person without that person's explicit consent;

that impersonates any person or entity, including, but not limited to, an SHAMUK employee, or falsely states or otherwise misrepresents an affiliation with a person or entity;

deceives or misleads the addressee about the origin of such messages or communicates any information which is grossly offensive or menacing in nature;

that is false, deceptive, misleading, deceitful, misinformative, or constitutes "bait and switch" offer;

that constitutes or contains "network marketing", "multi-level marketing", "Ponzi and pyramid schemes," "affiliate marketing," "link referral code," "junk mail," "spam," "chain letters," or unsolicited advertisements of a commercial nature;

that includes links to commercial services or Third Party Websites, except as specifically allowed by SHAMUK;

that advertises any illegal services or the sale of any items the sale of which is prohibited or restricted by applicable law, including without limitation items the sale of which is prohibited or regulated by applicable law of local jurisdiction;

that contains software viruses or any other computer code, files or programs designed to interrupt, destroy or limit the functionality of any computer software or hardware or telecommunications equipment or any other computer resource;

that disrupts the normal flow of dialogue with an excessive number of messages (flooding attack) to the Service, or that otherwise negatively affects other users' ability to use the Service; or

that employs misleading email addresses, or forged headers or otherwise manipulated identifiers in order to disguise the origin of Content transmitted through the Service.

Additionally, you agree not to:

contact anyone who has asked not to be contacted, or make unsolicited contact with anyone for any commercial purpose, specifically, contact any user to post advertisement on a third party Website or post any advertisement on behalf of such user; or to "stalk" or otherwise harass anyone;

make any libelous or defamatory comments or postings to or against anyone;

collect personal data about other users or entities for commercial or unlawful purposes;

use automated means, including spiders, robots, crawlers, data mining tools, or the like to download or scrape data from the Service, except for internet search engines (e.g,. Google) and non-commercial public archives (e.g. archive.org) that comply with our robots.txt file;

post Content that is outside the local area or not relevant to the local area, repeatedly post the same or similar Content, or otherwise impose unreasonable or disproportionately large loads on our servers and other infrastructure;

post the same item or service in multiple classified categories or forums, or in multiple metropolitan areas;

attempt to gain unauthorized access to computer systems owned or controlled by OLX or engage in any activity that disrupts, diminishes the quality of, interferes with the performance of, or impairs the functionality of, the Service or the Website.

use any form of automated device or computer program (sometimes referred to as "flagging tools") that enables the use of SHAMUK's "flagging system" or other community control systems without each flag being manually entered by a human that initiates the flag (an "automated flagging device"), or use any such flagging tool to remove posts of competitors, other third parties or to remove posts without a reasonable good faith belief that the post being flagged violates these Terms or any applicable law or regulation.

use any automated device or software that enables the submission of automatic postings on SHAMUK without human intervention or authorship (an "automated posting device"), including without limitation, the use of any such automated posting device in connection with bulk postings, or for automatic submission of postings at certain times or intervals; or

Any Content uploaded by you shall be subject to relevant laws and may be disabled, and/or may be subject to investigation under appropriate laws. Furthermore, if you are found to be in non-compliance with the laws and regulations, these terms, or the privacy policy of the Site, we may terminate your account/block your access to the Site and we reserve the right to remove any non-compliant Content uploaded by you.

Notice of Infringement of Intellectual Property

SHAMUK owns all intellectual property rights in the Website and the service, including without limitation, the design, text, graphics, ads, user uploaded pictures, vehicle description, vehicle inspection reports etc. the selection and arrangement thereof.

SHAMUK is not liable for any infringement of intellectual property rights arising out of materials posted on or transmitted through the site, or items advertised on the site, by end users or any other third parties.

If you are an owner of intellectual property rights or an agent who is fully authorized to act on behalf of the owner of intellectual property rights and believe that any content or other content infringes upon your intellectual property right or intellectual property right of the owner on whose behalf you are authorized to act, you may write to us at info@shamuk.com to request to delete the relevant Content in a good faith.""",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: themegreytextcolor,
                      fontSize: 14,
                    ),
                  ),
 SizedBox(height: 10,),
                  Text(
                    "RIGHT OF USER INFORMATION",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    """SHAMUK reserves the discretion to withdraw any material from the Website without prior notice and to refuse any material posted by a user. The user's registration details and data relating to its use of the Website will be recorded by SHAMUK but this information shall not be disclosed to third parties.

You agree that SHAMUK may use the user information shared by you to provide customer services and to understand if any other services or advertisement listed on SHAMUK Website may interest you or to inform the User about special offers, occasional third party offers and for other marketing and related purposes.

SHAMUK will not use User data for any other purposes than as set out in this agreement except that SHAMUK may disclose this data if compelled to do so by law, or at the request of a law enforcement agency or governmental authority.""",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: themegreytextcolor,
                      fontSize: 14,
                    ),
                  ),
                   SizedBox(height: 10,),
                  //No Spam Policy
                  Text(
                    "NO SPAM POLICY",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    """You understand and agree that sending unsolicited email advertisements or other unsolicited communications to SHAMUK email addresses or through SHAMUK computer systems are expressly prohibited by these Terms. You acknowledge and agree that from time to time SHAMUK may monitor email usage using human monitors or automated software to flag certain words associated with spam or scams in emails that are sent between one user to another in the SHAMUK e mail system. Any communication between yourself and any other user utilizing the communication features available on the Service and the Website may be used only in accordance with the Terms. Any unauthorized use of SHAMUK computer systems is a violation of these Terms and certain applicable laws. Such violations may subject the sender and his or her agents to civil and criminal liabilities and penalties.""",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: themegreytextcolor,
                      fontSize: 14,
                    ),
                  ),
                   SizedBox(height: 10,),
                  //DEALINGS WITH COMPANIES AND INDIVIDUALS
                  Text(
                    "DEALINGS WITH COMPANIES AND INDIVIDUALS",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    """You acknowledge and agree that SHAMUK shall not be liable for your interactions with any organizations and/or individuals on the Website or through the Service. This includes, but is not limited to, payment and delivery of goods and services, and any other terms, conditions, warranties or representations associated with any interaction you may have with other organizations and/or individuals. These dealings are solely between you and such organizations and/or individuals. You agree and acknowledge that SHAMUK shall not be responsible or liable for any loss or damage of any sort incurred as the result of any such dealings or interactions. If there is a dispute between participants on the Website, or between users and any third party, you understand and agree that SHAMUK is under no obligation to become involved in such dispute. In the event that you have a dispute with one or more other users, you hereby release SHAMUK , its officers, employees, agents and successors from any and all claims, demands and damages (actual and consequential) of every kind or nature, known or unknown, suspected and unsuspected, disclosed and undisclosed, arising out of or in any way related to such disputes and/or our Service.""",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: themegreytextcolor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10,),
                  //VIOLATION OF TERMS AND LIQUIDATED DAMAGES
                  Text(
                    "VIOLATION OF TERMS AND LIQUIDATED DAMAGES",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    """Please report any violations of the Terms that you become aware of by contacting us using the link at the bottom of the SHAMUK homepage at shamuk.com.pk. Any failure to act by SHAMUK with respect to a breach by you or others does not waive our right to act with respect to subsequent or similar breaches by you or others. Notwithstanding the aforesaid clauses regarding any other provision of these Terms, SHAMUK retains the right to seek legal and equitable remedies, including without limitation, specific performance of any term contained in these Terms, or a preliminary or permanent injunction against the breach or threatened breach of any such term or in aid of the exercise of any power granted in these Terms, or any combination thereof, without the necessity of posting a bond.""",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: themegreytextcolor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
