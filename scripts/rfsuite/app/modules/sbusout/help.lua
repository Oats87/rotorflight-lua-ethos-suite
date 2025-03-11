--[[
 * Copyright (C) Rotorflight Project
 *
 *
 * License GPLv3: https://www.gnu.org/licenses/gpl-3.0.en.html
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 
 * Note.  Some icons have been sourced from https://www.flaticon.com/
 * 

]] --
local data = {}

data['help'] = {}

data['help']['default'] = {
    rfsuite.i18n.get("app.modules.sbusout.help_default_p1"),
    rfsuite.i18n.get("app.modules.sbusout.help_default_p2"),
    rfsuite.i18n.get("app.modules.sbusout.help_default_p3"),
    rfsuite.i18n.get("app.modules.sbusout.help_default_p4"),
    rfsuite.i18n.get("app.modules.sbusout.help_default_p5"),
}

data['fields'] = {
    sbusOutSource = {t = rfsuite.i18n.get("app.modules.sbusout.help_fields_source")},
    sbusOutMin    = {t = rfsuite.i18n.get("app.modules.sbusout.help_fields_min")},
    sbusOutMax    = {t = rfsuite.i18n.get("app.modules.sbusout.help_fields_max")}
}

return data
