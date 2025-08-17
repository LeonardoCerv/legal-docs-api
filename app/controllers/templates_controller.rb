class TemplatesController < ApplicationController
  skip_before_action :authorized

  def show
    type = get_type(params[:type])
    if type
      @template = generate_template(params[:type])
      render json: @template, status: :ok
    else
      render json: { error: 'Template not found' }, status: :not_found
    end
  end

  private
    def get_type(type)
      {
        'terms_of_service' => TermsOfService,
        'privacy_policy' => PrivacyPolicy,
        'cookie_policy' => CookiePolicy,
        'disclaimer' => Disclaimer,
        'acceptable_use_policy' => AcceptableUsePolicy
      }[type]
    end
    
    def generate_template(type)
      case type
      when 'terms_of_service'
        <<~TERMS
          # Terms of Service

          **Effective Date:** [DATE]

          Welcome to [COMPANY NAME]. These Terms of Service ("Terms") govern your use of our website and services. By accessing or using our services, you agree to be bound by these Terms.

          ## 1. Acceptance of Terms

          By accessing and using this service, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.

          ## 2. Use License

          Permission is granted to temporarily download one copy of the materials on [COMPANY NAME]'s website for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title, and under this license you may not:
          - modify or copy the materials
          - use the materials for any commercial purpose or for any public display
          - attempt to reverse engineer any software contained on the website
          - remove any copyright or other proprietary notations from the materials

          ## 3. Disclaimer

          The materials on [COMPANY NAME]'s website are provided on an 'as is' basis. [COMPANY NAME] makes no warranties, expressed or implied, and hereby disclaims and negates all other warranties including without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights.

          ## 4. Limitations

          In no event shall [COMPANY NAME] or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use the materials on [COMPANY NAME]'s website, even if [COMPANY NAME] or an authorized representative has been notified orally or in writing of the possibility of such damage.

          ## 5. Terms of Service Modifications

          [COMPANY NAME] may revise these terms of service for its website at any time without notice. By using this website, you are agreeing to be bound by the then current version of these terms of service.

          ## 6. Governing Law

          These terms and conditions are governed by and construed in accordance with the laws of [JURISDICTION] and you irrevocably submit to the exclusive jurisdiction of the courts in that state or location.

          ## 7. Contact Information

          For questions about these Terms of Service, please contact us at [EMAIL ADDRESS].

          ---

          This document was last updated on [DATE].
        TERMS

      when 'privacy_policy'
        <<~PRIVACY
          # Privacy Policy

          **Effective Date:** [DATE]

          [COMPANY NAME] ("we," "our," or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit our website [WEBSITE URL] or use our services.

          ## 1. Information We Collect

          We may collect information about you in a variety of ways. The information we may collect includes:

          **Personal Data:** Personally identifiable information, such as your name, shipping address, email address, and telephone number, and demographic information, such as your age, gender, hometown, and interests, that you voluntarily give to us when you register with the service or when you choose to participate in various activities related to the service.

          **Derivative Data:** Information our servers automatically collect when you access the service, such as your IP address, your browser type, your operating system, your access times, and the pages you have viewed directly before and after accessing the service.

          ## 2. Use of Your Information

          Having accurate information about you permits us to provide you with a smooth, efficient, and customized experience. Specifically, we may use information collected about you via the service to:
          - Create and manage your account
          - Process your transactions
          - Email you regarding your account or order
          - Fulfill and manage purchases, orders, payments, and other transactions
          - Generate a personal profile about you to make future visits to the service more personalized
          - Increase the efficiency and operation of the service
          - Monitor and analyze usage and trends to improve your experience with the service

          ## 3. Disclosure of Your Information

          We may share information we have collected about you in certain situations. Your information may be disclosed as follows:

          **By Law or to Protect Rights:** If we believe the release of information about you is necessary to respond to legal process, to investigate or remedy potential violations of our policies, or to protect the rights, property, and safety of others, we may share your information as permitted or required by any applicable law, rule, or regulation.

          **Business Transfers:** We may share or transfer your information in connection with, or during negotiations of, any merger, sale of company assets, financing, or acquisition of all or a portion of our business to another company.

          ## 4. Security of Your Information

          We use administrative, technical, and physical security measures to help protect your personal information. While we have taken reasonable steps to secure the personal information you provide to us, please be aware that despite our efforts, no security measures are perfect or impenetrable.

          ## 5. Policy for Children

          We do not knowingly solicit information from or market to children under the age of 13. If we learn that we have collected personal information from a child under age 13 without verification of parental consent, we will delete that information as quickly as possible.

          ## 6. Changes to This Privacy Policy

          We may update this Privacy Policy from time to time in order to reflect, for example, changes to our practices or for other operational, legal, or regulatory reasons.

          ## 7. Contact Us

          If you have questions or comments about this Privacy Policy, please contact us at [EMAIL ADDRESS].

          ---

          This document was last updated on [DATE].
        PRIVACY

      when 'cookie_policy'
        <<~COOKIES
          # Cookie Policy

          **Effective Date:** [DATE]

          This Cookie Policy explains how [COMPANY NAME] ("we," "our," or "us") uses cookies and similar technologies to recognize you when you visit our website at [WEBSITE URL].

          ## 1. What Are Cookies

          Cookies are small data files that are placed on your computer or mobile device when you visit a website. Cookies are widely used by website owners in order to make their websites work, or to work more efficiently, as well as to provide reporting information.

          ## 2. Why Do We Use Cookies

          We use first party and third party cookies for several reasons. Some cookies are required for technical reasons in order for our website to operate, and we refer to these as "essential" or "strictly necessary" cookies. Other cookies also enable us to track and target the interests of our users to enhance the experience on our website.

          ## 3. Types of Cookies We Use

          **Essential Cookies:** These cookies are strictly necessary to provide you with services available through our website and to use some of its features.

          **Performance and Functionality Cookies:** These cookies are used to enhance the performance and functionality of our website but are non-essential to their use. However, without these cookies, certain functionality may become unavailable.

          **Analytics and Customization Cookies:** These cookies collect information that is used either in aggregate form to help us understand how our website is being used or how effective our marketing campaigns are, or to help us customize our website for you.

          **Advertising Cookies:** These cookies are used to make advertising messages more relevant to you and your interests.

          ## 4. How Can You Control Cookies

          You have the right to decide whether to accept or reject cookies. You can exercise your cookie rights by setting your preferences in the Cookie Consent Manager. The Cookie Consent Manager allows you to select which categories of cookies you accept or reject.

          You can also set or amend your web browser controls to accept or refuse cookies. As the means by which you can refuse cookies through your web browser controls vary from browser-to-browser, you should visit your browser's help menu for more information.

          ## 5. Updates to This Cookie Policy

          We may update this Cookie Policy from time to time in order to reflect, for example, changes to the cookies we use or for other operational, legal or regulatory reasons.

          ## 6. Where Can You Get Further Information

          If you have any questions about our use of cookies or other technologies, please email us at [EMAIL ADDRESS].

          ---

          This document was last updated on [DATE].
        COOKIES

      when 'disclaimer'
        <<~DISCLAIMER
          # Disclaimer

          **Effective Date:** [DATE]

          The information contained in this website is for general information purposes only. The information is provided by [COMPANY NAME] and while we endeavor to keep the information up to date and correct, we make no representations or warranties of any kind, express or implied, about the completeness, accuracy, reliability, suitability or availability with respect to the website or the information, products, services, or related graphics contained on the website for any purpose.

          ## 1. No Professional Advice

          The content on this website is provided for general information purposes only and does not constitute professional advice. We recommend that you seek professional advice before acting or relying on any of the content of this website.

          ## 2. Limitation of Liability

          In no event will [COMPANY NAME] be liable for any loss or damage including without limitation, indirect or consequential loss or damage, or any loss or damage whatsoever arising from loss of data or profits arising out of, or in connection with, the use of this website.

          ## 3. External Links Disclaimer

          Through this website you are able to link to other websites which are not under the control of [COMPANY NAME]. We have no control over the nature, content and availability of those sites. The inclusion of any links does not necessarily imply a recommendation or endorse the views expressed within them.

          ## 4. Website Availability

          Every effort is made to keep the website up and running smoothly. However, [COMPANY NAME] takes no responsibility for, and will not be liable for, the website being temporarily unavailable due to technical issues beyond our control.

          ## 5. Accuracy of Information

          While we strive to provide accurate and up-to-date information, we make no representations or warranties of any kind, express or implied, about the completeness, accuracy, reliability, suitability, or availability of the information contained on this website.

          ## 6. Changes to This Disclaimer

          [COMPANY NAME] reserves the right to modify this disclaimer at any time without prior notice. Your continued use of this website following any changes indicates your acceptance of the modified disclaimer.

          ## 7. Contact Us

          If you have any questions about this disclaimer, please contact us at [EMAIL ADDRESS].

          ---

          This document was last updated on [DATE].
        DISCLAIMER

      when 'acceptable_use_policy'
        <<~AUP
          # Acceptable Use Policy

          **Effective Date:** [DATE]

          This Acceptable Use Policy ("Policy") governs your use of the services provided by [COMPANY NAME] ("we," "our," or "us"). By using our services, you agree to comply with this Policy.

          ## 1. Permitted Uses

          You may use our services only for lawful purposes and in accordance with this Policy. You agree to use our services in a manner that:
          - Complies with all applicable laws and regulations
          - Respects the rights and dignity of others
          - Does not interfere with or disrupt the services or servers connected to the services
          - Does not attempt to gain unauthorized access to any part of the services

          ## 2. Prohibited Uses

          You may not use our services:
          - For any unlawful purpose or to solicit others to take unlawful actions
          - To violate any international, federal, provincial, or state regulations, rules, laws, or local ordinances
          - To transmit or procure the sending of any advertising or promotional material without our prior written consent
          - To impersonate or attempt to impersonate the company, a company employee, another user, or any other person or entity
          - To harass, annoy, intimidate, or threaten any other users of the services
          - To use the services in any manner that could disable, overburden, damage, or impair the services

          ## 3. Prohibited Content

          You may not post, upload, transmit, share, or otherwise make available any content that:
          - Is unlawful, harmful, threatening, abusive, harassing, defamatory, vulgar, obscene, or otherwise objectionable
          - Infringes any patent, trademark, trade secret, copyright, or other intellectual property rights
          - Contains software viruses or any other computer code designed to interrupt, destroy, or limit functionality
          - Is unsolicited or unauthorized advertising, promotional materials, spam, or any other form of solicitation
          - Contains personal information of third parties without their consent

          ## 4. User Responsibilities

          As a user of our services, you are responsible for:
          - Maintaining the confidentiality of your account and password
          - All activities that occur under your account
          - Ensuring that your use of the services complies with this Policy
          - Reporting any violations of this Policy to us

          ## 5. Enforcement

          We reserve the right to:
          - Remove or refuse to post any content that violates this Policy
          - Take any action with respect to any content that we deem necessary or appropriate
          - Terminate or suspend your access to all or part of the services for any reason
          - Take appropriate legal action, including referring the matter to law enforcement

          ## 6. Reporting Violations

          If you become aware of any violations of this Policy, please report them to us immediately at [EMAIL ADDRESS]. We will investigate all reported violations and take appropriate action.

          ## 7. Changes to This Policy

          We may revise this Policy from time to time. The most current version will always be posted on our website. Your continued use of the services following any changes indicates your acceptance of the revised Policy.

          ## 8. Contact Us

          If you have any questions about this Acceptable Use Policy, please contact us at [EMAIL ADDRESS].

          ---

          This document was last updated on [DATE].
        AUP
      end
    end
end
