# Código de ejemplo de Application Package PT_MCF_MAIL:MCFOutboundEmail 

Tomado de [http://www.pscustomizer.com/peoplesoft-examples/email-with-app-package/](http://www.pscustomizer.com/peoplesoft-examples/email-with-app-package/)

```
Import PT_MCF_MAIL:*;

Local PT_MCF_MAIL:MCFOutboundEmail &email;
Local boolean &done;
Local integer &res;

Function Email_Example(&Email_Address_To As string, &Email_Address_From As string, &Subject As string,
                       &BodyText_or_HTML as string, &ContentType as string);

   /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
   /* &Email_Address_To takes standard email format:              */
   /*  myname@mydomain.com – if multiple addresses then           */
   /*  separate by commas                                         */
   /* &Email_Address_From takes standard email format:            */
   /*  myname@mydomain.com                                        */
   /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */

   /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
   /* Instantiate the App Package Class                           */
   /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
   &email = create PT_MCF_MAIL:MCFOutboundEmail();

   /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
   /* Set Email Object Properties                                 */
   /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
   &email.From = &Email_Address_From;
   &email.Recipients = &Email_Address_To;
   &email.Subject = &Subject;
   &email.Text = &BodyText_or_HTML;

   /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
   /* Could be "text/plain", "text/html", or                      */
   /*      "multipart/alternative"                                */
   /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
   &email.ContentType = &ContentType;

   /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
   /* Invoke the method to generate the email                     */
   /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
   &res = &email.Send();

   Evaluate &res
   When %ObEmail_Delivered
      /* every thing ok */

      &done = True;
      MessageBox(0, "", 0, 0, "Email Sent Successfully");
      Break;

   When %ObEmail_NotDelivered
      /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
      /* Check &email.InvalidAddresses, &email.ValidSentAddresses */
      /*   and &email.ValidUnsentAddresses                        */
      /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */

      &done = False;
      MessageBox(0, "", 0, 0, "Email Not delivered" |
          &eMail.InvalidAddresses | &eMail.ValidSentAddresses |
          &eMail.ValidUnsentAddresses);
      Break;

   When %ObEmail_PartiallyDelivered
      /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
      /* Check &email.InvalidAddresses, &email.ValidSentAddresses */
      /*   and &email.ValidUnsentAddresses                        */
      /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */

      &done = True;
      MessageBox(0, "", 0, 0, "Email Partially delivered" |
          &eMail.InvalidAddresses | &eMail.ValidSentAddresses |
          &eMail.ValidUnsentAddresses);
      Break;

   When %ObEmail_FailedBeforeSending
      /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
      /* Get the Message Set Number, message number;              */
      /*   Or just get the formatted messages from                */
      /*   &email.ErrorDescription, email.ErrorDetails;           */
      /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */

      &done = False;
      MessageBox(0, "", 0, 0, "Email Failed Before Sending" |
          &eMail.ErrorDescription | &eMail.ErrorDetails);
      Break;

   End-Evaluate;

End-Function;
```