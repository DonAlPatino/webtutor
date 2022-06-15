function _email(options, emails) {
    try {
        var new_doc = tools.new_doc_by_name('active_notification');
        var doc_topElem = new_doc.TopElem;
                                for (elem in emails)
                                {
                                                recipient = doc_topElem.recipients.AddChild("recipient");
                                                recipient.address = elem.email;                                 
                                }
        doc_topElem.send_date = Date();
        doc_topElem.is_custom = 1;
        doc_topElem.status = 'active';
        doc_topElem.body_type = 'html';
        doc_topElem.subject = "Сообщение от тестового сервера!!! " + options.subject;
        doc_topElem.sender.name = 'nrsportal@nrservice.ru';
        doc_topElem.sender.address = 'nrsportal@nrservice.ru';
        doc_topElem.body = options.body;
        new_doc.BindToDb(DefaultDb);
        new_doc.Save();
        return {}
    }
    catch (err) {
                                alert(err);
      //  throw new Error('_email: ' + err.message)
    }
}
nTemplateID = 6872817148292725259;
docTemplate = tools.open_doc(nTemplateID).TopElem;
sEmail = ArrayOptFind(docTemplate.wvars, 'This.name == "fail_email"').value;
aEmail = Array();
oEmailPersonEmail = {};
oEmailPersonEmail.email = sEmail;
aEmail.push(oEmailPersonEmail);
if (sEmail != '')
{
                aRequestTypes = XQuery("for $elem in request_types where contains($elem/code,'doc_') return $elem");
                for (elem in aRequestTypes)
                {
                                aRequests = XQuery("for $elem in requests where $elem/request_type_id = "+elem.id+" and $elem/status_id != 'close' and $elem/workflow_state != '3' and $elem/create_date >= date('19.02.2021 00:00:00') return $elem");
                                for (req in aRequests)
                                {
                                                docRequest = tools.open_doc(req.id);
                                                if (docRequest != undefined)
                                                {
                                                                dPlan = docRequest.TopElem.custom_elems.ObtainChildByKey("date_plan").value;
                                                                if (dPlan != '')
                                                                {
                                                                                if ( ParseDate(Date()) > ParseDate(dPlan)  )
                                                                                {
                                                                                                docRequest.TopElem.custom_elems.ObtainChildByKey('days_fail').value = Int(DateDiff( ParseDate(Date()), ParseDate(dPlan) ) / 86400  );
                                                                                                docRequest.Save();

                                                                                                oEmailPersonOption = {};
                                                                                                oEmailPersonOption.subject = "Срок изготовления документа истек";
                                                                                                oEmailPersonOption.body = "<p>Добрый день!</p>";
                                                                                                oEmailPersonOption.body += "<p>Срок заявки на изготовление документа '"+docRequest.TopElem.name+"' истек.</p>";
                                                                                                oEmailPersonOption.body += "<p>Для просмотра заявки перейдите по <a href='https://priserv9032.pristav.int/view_doc.html?mode=request&doc_id=&object_id="+req.id+"'>ссылке</a></p>";
                                                                                                _email(oEmailPersonOption, aEmail);
                                                                                }
                                                                }
                                                }
                                }
                }
}
