#!/usr/bin/env python3
from mwclient import Site
import wikitextparser as wtp
from datetime import date, timedelta
import json

result = dict()

site = Site("wiki.chaosdorf.de", path="/")

# get the date of the current week's Friday
today = date.today()
friday_date = today + timedelta(days=4-today.weekday())

# load the correct pag
page = site.pages["Freitagsfoo/{}".format(friday_date)]
sections = wtp.parse(page.text()).sections

# parse the top section
top_section = page.text(section=0)
parsed_top_section = wtp.parse(top_section)
parsed_event = parsed_top_section.templates[0]
result["host"] = parsed_event.get_arg("Host").value.strip()
result["date"] = parsed_event.get_arg("Date").value.strip()
assert result["date"] == str(friday_date)

# remaining sections are talks
result["talks"] = list()
for section in sections[1:]:
    talk = dict()
    talk["title"] = section.title.strip()
    # TODO: talk["description"]
    talk["persons"] = list()
    section = wtp.parse(section.string)  # bug!
    # `[[User:FIXME|FIXME]]`
    for wikilink in section.wikilinks:
        if wikilink.target.startswith("User:"):
            talk["persons"].append(
                wikilink.target.replace("User:", "").lower()
            )
    # `{{U|FIXME}}`
    for template in section.templates:
        if template.name == "U":
            talk["persons"].append(
                template.arguments[0].value.lower()
            )
    result["talks"].append(talk)

json.dump(result, open("freitagsfoo.json", "w"))
