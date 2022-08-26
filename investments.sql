UPDATE StatementItem set	StatementItemFA = N'سود (زیان) تغییر ارزش سرمایه گذاری ها' WHERE StatementItemKey = 3111;
UPDATE StatementItem set	StatementItemFA = N'تفاوت تسعیر ارز عملیات خارجی' WHERE StatementItemKey = 3009;

select * from StatementItem WHERE StatementItemFA LIKE N'%%'

SELECT 
s1.AuditingKey,
s1.CompanyKey,
s1.ConsolidatedKey,
s1.CurrencyKey,
s1.FiscalMonthEndDayKey,
s1.FiscalMonthKey,
s1.FiscalYearEndDayKey,
s1.GrowthRateAnnual,
s1.GrowthRateHalfYearYoY,
s1.GrowthRateHoH,
s1.GrowthRateQoQ,
s1.GrowthRateYoY,
s1.ModifiedTime,
s1.PublishDateTime,
s1.PublishDayKey,
s1.ScenarioKey,
s1.SentDayKey,
230 as StatementItemKey, --نقد حاصل از عملیات
s1.StatementKey,
s1.StatementTypeKey,
s1.TextKey,
s1.TimeZoneKey,
(s1.[Value] + s2.[Value]) as [Value],
(s1.ValueHalfYear + s2.ValueHalfYear) as ValueHalfYear,
(s1.ValueQuarterly + s2.ValueQuarterly) as ValueQuarterly
from StatementItemValue s1 
JOIN StatementItemValue s2 
on s1.StatementKey == s2.StatementKey 
and s1.StatementItemKey = 132 -- جریان خالص ورود (خروج) وجه نقد ناشی از فعالیتهای عملیاتی
and s2.StatementItemKey = 138 -- مالیات بر درامد پرداختنی 
JOIN Company c ON
c.CompanyKey = s1.CompanyKey
and c.CompanyTypeKey = 1000002 -- سرمایه گذاری  
and c.CompanyActivityKey != 14 -- غیر کارگزاری
