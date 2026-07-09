<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="color-scheme" content="dark">
<title>FinanceFlow — Gestão Financeira</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=JetBrains+Mono:wght@400;600;700&display=swap" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js" defer></script>
<style>
:root{
  --bg:#080c14;--bg2:#0d1420;--surface:#111827;
  --card:rgba(255,255,255,.04);--cardh:rgba(255,255,255,.07);
  --b:rgba(255,255,255,.08);--bh:rgba(34,197,94,.4);
  --green:#22c55e;--gd:rgba(34,197,94,.12);--gg:rgba(34,197,94,.25);
  --indigo:#818cf8;--id:rgba(129,140,248,.12);
  --red:#ef4444;--rd:rgba(239,68,68,.12);
  --amber:#f59e0b;--ad:rgba(245,158,11,.12);
  --sky:#38bdf8;--skd:rgba(56,189,248,.12);
  --t1:#f8fafc;--t2:#94a3b8;--t3:#475569;--t4:#1e293b;
  --sw:256px;--r:12px;--rs:8px;--rl:18px;
  --f:'Inter',system-ui,sans-serif;--m:'JetBrains Mono',monospace;
  --ease:cubic-bezier(.4,0,.2,1);
}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html,body{height:100%}
body{font-family:var(--f);background:var(--bg);color:var(--t1);-webkit-font-smoothing:antialiased;overflow:hidden}
body::before{content:'';position:fixed;inset:0;pointer-events:none;z-index:0;
  background:
    radial-gradient(ellipse 60% 60% at 15% 40%,rgba(34,197,94,.06) 0%,transparent 70%),
    radial-gradient(ellipse 60% 60% at 85% 15%,rgba(129,140,248,.07) 0%,transparent 70%),
    linear-gradient(rgba(255,255,255,.014) 1px,transparent 1px),
    linear-gradient(90deg,rgba(255,255,255,.014) 1px,transparent 1px);
  background-size:auto,auto,56px 56px,56px 56px}

.orbs{position:fixed;inset:0;pointer-events:none;overflow:hidden;z-index:0}
.orb{position:absolute;border-radius:50%;filter:blur(80px);opacity:.6;animation:floatOrb 18s ease-in-out infinite}
.o1{width:420px;height:420px;background:rgba(34,197,94,.08);top:-100px;left:-80px;animation-delay:0s}
.o2{width:520px;height:520px;background:rgba(129,140,248,.07);bottom:-120px;right:-100px;animation-delay:-7s}
.o3{width:320px;height:320px;background:rgba(56,189,248,.05);top:40%;left:60%;animation-delay:-13s}
@keyframes floatOrb{0%,100%{transform:translate(0,0)}40%{transform:translate(30px,-40px)}70%{transform:translate(-20px,25px)}}

.screen{position:fixed;inset:0;z-index:10;display:none}
.screen.active{display:flex;animation:scIn .35s var(--ease)}
@keyframes scIn{from{opacity:0;transform:scale(.98)}to{opacity:1;transform:scale(1)}}

/* ════════════ AUTH SCREEN ════════════ */
#sc-auth{align-items:stretch;justify-content:stretch}
.auth-left{
  flex:1;display:flex;flex-direction:column;justify-content:center;padding:60px 56px;
  background:linear-gradient(145deg,rgba(34,197,94,.08) 0%,rgba(129,140,248,.08) 100%);
  border-right:1px solid var(--b);position:relative;overflow:hidden}
.auth-left::after{content:'';position:absolute;inset:0;
  background:radial-gradient(ellipse at 30% 70%,rgba(34,197,94,.12),transparent 70%)}
.al-logo{font-size:28px;font-weight:800;margin-bottom:4px;position:relative;z-index:1;
  background:linear-gradient(135deg,var(--green),var(--indigo));
  -webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}
.al-tag{font-size:13px;color:var(--t3);margin-bottom:40px;position:relative;z-index:1}
.al-heading{font-size:36px;font-weight:800;line-height:1.18;letter-spacing:-.5px;margin-bottom:12px;position:relative;z-index:1}
.al-heading span{background:linear-gradient(135deg,var(--green),#86efac);
  -webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}
.al-desc{font-size:15px;color:var(--t2);line-height:1.6;margin-bottom:36px;position:relative;z-index:1}
.al-features{display:flex;flex-direction:column;gap:12px;position:relative;z-index:1}
.al-feat{display:flex;align-items:center;gap:12px;font-size:14px;color:var(--t2)}
.al-feat span{width:28px;height:28px;background:var(--gd);border-radius:8px;
  display:flex;align-items:center;justify-content:center;font-size:14px;flex-shrink:0}
.auth-right{
  width:440px;min-width:440px;display:flex;flex-direction:column;
  justify-content:center;padding:48px 44px;overflow-y:auto}
.ar-logo{font-size:22px;font-weight:800;margin-bottom:28px;
  background:linear-gradient(135deg,var(--green),var(--indigo));
  -webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}
.auth-tabs{display:flex;background:var(--bg);border-radius:var(--rs);padding:4px;margin-bottom:28px;gap:2px}
.atab{flex:1;padding:9px;border:none;background:transparent;color:var(--t2);
  border-radius:6px;cursor:pointer;font-size:13.5px;font-family:var(--f);font-weight:600;transition:all .2s}
.atab.active{background:var(--cardh);color:var(--t1);box-shadow:0 1px 4px rgba(0,0,0,.3)}
.auth-form{display:none}.auth-form.active{display:block;animation:scIn .2s}
.inp-wrap{position:relative;margin-bottom:14px}
.inp-wrap label{display:block;font-size:11.5px;font-weight:600;color:var(--t2);margin-bottom:6px;
  text-transform:uppercase;letter-spacing:.06em}
.inp-wrap input{width:100%;background:var(--bg);border:1.5px solid var(--b);border-radius:var(--rs);
  padding:11px 14px 11px 40px;color:var(--t1);font-family:var(--f);font-size:14px;outline:none;
  transition:border-color .2s,box-shadow .2s}
.inp-wrap input:focus{border-color:var(--green);box-shadow:0 0 0 3px var(--gd)}
.inp-wrap input.invalid{border-color:var(--red)}
.inp-wrap .ico{position:absolute;left:13px;bottom:11px;color:var(--t3);font-size:16px;pointer-events:none}
.inp-hint{font-size:11px;margin-top:5px;min-height:14px;line-height:1.4}
.inp-hint.err{color:var(--red)}.inp-hint.ok{color:var(--green)}
.auth-err{background:var(--rd);border:1px solid rgba(239,68,68,.25);border-radius:var(--rs);
  padding:10px 14px;font-size:13px;color:#fca5a5;margin-bottom:14px;display:none;line-height:1.5}
.auth-ok{background:var(--gd);border:1px solid rgba(34,197,94,.25);border-radius:var(--rs);
  padding:10px 14px;font-size:13px;color:#86efac;margin-bottom:14px;display:none;line-height:1.5}
.auth-link{background:none;border:none;color:var(--green);cursor:pointer;font-size:12.5px;
  font-family:var(--f);font-weight:600;padding:0;margin-top:2px}
.auth-link:hover{text-decoration:underline}
.auth-foot{margin-top:16px;text-align:center;font-size:12.5px;color:var(--t3)}
@media(max-width:900px){
  .auth-left{display:none}
  .auth-right{width:100%;min-width:0;padding:40px 28px}}

/* ════════════ APP SCREEN ════════════ */
#sc-app{flex-direction:row}
.sb{width:var(--sw);min-width:var(--sw);height:100vh;background:var(--surface);
  border-right:1px solid var(--b);display:flex;flex-direction:column;
  overflow:hidden;position:relative;z-index:20}
.sb-logo{padding:22px 18px;border-bottom:1px solid var(--b);
  font-size:20px;font-weight:800;letter-spacing:-.3px;
  background:linear-gradient(135deg,var(--green),var(--indigo));
  -webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}
.sb-logo em{font-style:normal;opacity:.55;font-weight:300}
.sb-sec{padding:18px 16px 6px;font-size:10px;font-weight:700;color:var(--t3);
  text-transform:uppercase;letter-spacing:.1em}
.sb-nav{flex:1;padding:6px 10px;display:flex;flex-direction:column;gap:2px;overflow-y:auto}
.sb-item{display:flex;align-items:center;gap:10px;padding:9px 10px;
  border-radius:10px;cursor:pointer;color:var(--t2);font-size:13.5px;font-weight:500;
  border:1px solid transparent;transition:all .18s var(--ease);user-select:none}
.sb-item:hover{background:var(--card);color:var(--t1)}
.sb-item.on{background:var(--gd);color:var(--green);border-color:rgba(34,197,94,.18)}
.sb-item svg{width:16px;height:16px;flex-shrink:0}
.sb-foot{padding:14px 16px;border-top:1px solid var(--b);display:flex;align-items:center;gap:10px}
.sb-av{width:34px;height:34px;border-radius:50%;flex-shrink:0;overflow:hidden;
  background:linear-gradient(135deg,var(--green),var(--indigo));
  display:flex;align-items:center;justify-content:center;
  font-size:13px;font-weight:700;color:#040a06;cursor:pointer;background-size:cover;background-position:center}
.sb-ui{flex:1;min-width:0;cursor:pointer}
.sb-name{font-size:13px;font-weight:600;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.sb-email{font-size:11px;color:var(--t3);white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.sb-out{background:none;border:none;cursor:pointer;color:var(--t3);padding:4px;
  border-radius:6px;display:flex;transition:color .2s;flex-shrink:0}
.sb-out:hover{color:var(--red)}

.main{flex:1;display:flex;flex-direction:column;overflow:hidden;height:100vh}
.mhdr{padding:18px 28px;border-bottom:1px solid var(--b);
  display:flex;align-items:center;justify-content:space-between;flex-shrink:0;gap:12px;
  background:rgba(8,12,20,.85);backdrop-filter:blur(14px)}
.mhdr h1{font-size:20px;font-weight:700;letter-spacing:-.3px}
.mhdr-sub{font-size:12px;color:var(--t2);margin-top:2px}
.mhdr-right{display:flex;align-items:center;gap:14px}
.mnav{display:flex;align-items:center;gap:4px;background:var(--surface);
  border:1px solid var(--b);border-radius:var(--rs);padding:3px}
.mnav.hidden{display:none}
.mnav-btn{width:30px;height:30px;border:none;background:transparent;color:var(--t2);
  border-radius:6px;cursor:pointer;display:flex;align-items:center;justify-content:center;
  transition:all .18s var(--ease)}
.mnav-btn:hover{background:var(--card);color:var(--t1)}
.mnav-btn:active{transform:scale(.9)}
.mnav-label{min-width:132px;text-align:center;border:none;background:transparent;
  color:var(--t1);font-family:var(--f);font-size:13.5px;font-weight:600;cursor:pointer;
  padding:6px 8px;border-radius:6px;transition:background .18s;white-space:nowrap;text-transform:capitalize}
.mnav-label:hover{background:var(--card)}
.mnav-label.current{color:var(--green)}
@media(max-width:768px){
  .mnav-label{min-width:104px;font-size:12.5px}
  .mhdr-right{gap:8px}}
/* transição suave ao trocar de mês */
.page-switching{animation:monthFade .28s var(--ease)}
@keyframes monthFade{from{opacity:.35;transform:translateY(4px)}to{opacity:1;transform:translateY(0)}}
.mcontent{flex:1;overflow-y:auto;padding:24px 28px}
.mcontent::-webkit-scrollbar{width:4px}
.mcontent::-webkit-scrollbar-track{background:transparent}
.mcontent::-webkit-scrollbar-thumb{background:var(--t4);border-radius:4px}

.page{display:none}
.page.on{display:block;animation:pgIn .3s var(--ease)}
@keyframes pgIn{from{opacity:0;transform:translateY(8px)}to{opacity:1;transform:translateY(0)}}

.g2{display:grid;grid-template-columns:1fr 1fr;gap:14px}
.g3{display:grid;grid-template-columns:repeat(3,1fr);gap:14px}
.g4{display:grid;grid-template-columns:repeat(4,1fr);gap:14px}
.gch{display:grid;grid-template-columns:1fr 1.8fr;gap:14px}
@media(max-width:1200px){.g4{grid-template-columns:1fr 1fr}.gch{grid-template-columns:1fr}}
@media(max-width:768px){.g2,.g3{grid-template-columns:1fr}.sb{width:56px;min-width:56px}
  .sb-item .sb-txt{display:none}.sb-logo em{display:none}.sb-ui,.sb-out{display:none}
  .mhdr{padding:14px 16px}.mcontent{padding:14px 16px}}

.card{background:var(--card);border:1px solid var(--b);border-radius:var(--r);
  padding:20px;transition:all .22s var(--ease);position:relative;overflow:hidden}
.card:hover{border-color:var(--bh);background:var(--cardh);transform:translateY(-2px)}
.card-lbl{font-size:11px;font-weight:700;color:var(--t2);text-transform:uppercase;
  letter-spacing:.07em;margin-bottom:8px}
.card-val{font-family:var(--m);font-size:22px;font-weight:700}
.card-sub{font-size:12px;color:var(--t3);margin-top:4px}
.card-bar{position:absolute;bottom:0;left:0;right:0;height:2.5px;opacity:0;
  transition:opacity .22s;border-radius:0 0 var(--r) var(--r)}
.card:hover .card-bar{opacity:1}
.bar-g{background:var(--green)}.bar-r{background:var(--red)}
.bar-i{background:var(--indigo)}.bar-a{background:var(--amber)}

.sec{display:flex;align-items:center;justify-content:space-between;
  margin-bottom:14px;margin-top:22px}
.sec:first-child{margin-top:0}
.sec h2{font-size:15px;font-weight:700;letter-spacing:-.2px}

.btn{display:inline-flex;align-items:center;gap:7px;padding:9px 20px;
  border-radius:var(--rs);border:none;cursor:pointer;font-size:13.5px;font-weight:600;
  font-family:var(--f);transition:all .2s var(--ease);white-space:nowrap}
.btn:disabled{opacity:.6;cursor:not-allowed}
.btn-g{background:var(--green);color:#04130a}
.btn-g:hover:not(:disabled){filter:brightness(1.1);box-shadow:0 4px 20px var(--gg);transform:translateY(-1px)}
.btn-g:active:not(:disabled){transform:scale(.97)}
.btn-o{background:transparent;color:var(--t1);border:1.5px solid var(--b)}
.btn-o:hover:not(:disabled){border-color:var(--bh);background:var(--card)}
.btn-r{background:var(--rd);color:var(--red);border:1px solid rgba(239,68,68,.2)}
.btn-r:hover:not(:disabled){background:rgba(239,68,68,.2)}
.btn-sm{padding:6px 13px;font-size:12.5px}
.btn-ic{width:32px;height:32px;padding:0;justify-content:center}
.btn-full{width:100%;justify-content:center;padding:12px}

.fg{margin-bottom:14px}
.fr{display:grid;grid-template-columns:1fr 1fr;gap:12px}
@media(max-width:480px){.fr{grid-template-columns:1fr}}
label.lbl{display:block;font-size:11px;font-weight:700;color:var(--t2);margin-bottom:6px;
  text-transform:uppercase;letter-spacing:.06em}
input.inp,select.inp,textarea.inp{
  width:100%;background:var(--bg);border:1.5px solid var(--b);border-radius:var(--rs);
  padding:10px 13px;color:var(--t1);font-family:var(--f);font-size:13.5px;
  outline:none;transition:border-color .2s,box-shadow .2s}
input.inp:focus,select.inp:focus,textarea.inp:focus{border-color:var(--green);box-shadow:0 0 0 3px var(--gd)}
input.inp.invalid{border-color:var(--red)}
select.inp option{background:var(--surface)}
input.inp[type=number]{font-family:var(--m)}
.fhelp{font-size:11.5px;color:var(--t3);margin-top:4px;line-height:1.5}
.ferr{font-size:11.5px;color:var(--red);margin-top:4px;min-height:14px;display:none}
.ferr.show{display:block}

.mvi{display:flex;align-items:center;gap:12px;padding:11px 14px;
  background:var(--card);border:1px solid var(--b);border-radius:var(--r);
  margin-bottom:8px;transition:all .2s var(--ease)}
.mvi:hover{border-color:var(--bh);background:var(--cardh)}
.mvi-em{width:36px;height:36px;background:var(--bg);border-radius:9px;
  display:flex;align-items:center;justify-content:center;font-size:17px;flex-shrink:0}
.mvi-inf{flex:1;min-width:0}
.mvi-d{font-size:13.5px;font-weight:500;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.mvi-m{font-size:11.5px;color:var(--t2);margin-top:2px}
.mvi-v{font-family:var(--m);font-size:14px;font-weight:700;flex-shrink:0;text-align:right}
.mvi-v.entrada{color:var(--green)}.mvi-v.saida{color:var(--red)}
.mvi-v.investimento{color:var(--indigo)}.mvi-v.reserva{color:var(--amber)}
.mvi-acts{display:flex;gap:4px;flex-shrink:0}

.badge{display:inline-flex;align-items:center;padding:2px 8px;border-radius:20px;
  font-size:10px;font-weight:700;text-transform:uppercase;letter-spacing:.04em}
.bg{background:var(--gd);color:var(--green)}.br{background:var(--rd);color:var(--red)}
.bi{background:var(--id);color:var(--indigo)}.ba{background:var(--ad);color:var(--amber)}
.bs{background:var(--skd);color:var(--sky)}

.prog{height:6px;background:var(--bg2);border-radius:4px;overflow:hidden;margin:10px 0}
.pf{height:100%;border-radius:4px;transition:width 1.2s var(--ease)}
.pfg{background:linear-gradient(90deg,var(--green),#86efac)}
.pfr{background:var(--red)}.pfi{background:var(--indigo)}.pfa{background:var(--amber)}

.dv{height:1px;background:var(--b);margin:16px 0}

.empty{text-align:center;padding:52px 24px;color:var(--t2)}
.empty-ico{font-size:44px;margin-bottom:12px}
.empty h3{font-size:15px;font-weight:600;color:var(--t1);margin-bottom:6px}
.empty p{font-size:13px;line-height:1.6}

/* Skeleton loading */
.skel{background:linear-gradient(90deg,var(--card) 25%,var(--cardh) 50%,var(--card) 75%);
  background-size:200% 100%;animation:shimmer 1.3s infinite;border-radius:var(--r)}
@keyframes shimmer{0%{background-position:200% 0}100%{background-position:-200% 0}}
.skel-card{height:96px;margin-bottom:14px}
.skel-row{height:60px;margin-bottom:8px}

#mbg{position:fixed;inset:0;background:rgba(0,0,0,.8);backdrop-filter:blur(10px);
  z-index:100;display:none;align-items:center;justify-content:center;padding:20px}
#mbg.open{display:flex;animation:fIn .18s}
@keyframes fIn{from{opacity:0}to{opacity:1}}
#mbox{background:var(--surface);border:1px solid var(--b);border-radius:var(--rl);
  width:100%;max-width:520px;max-height:88vh;overflow-y:auto;
  animation:mIn .28s var(--ease)}
@keyframes mIn{from{opacity:0;transform:scale(.93) translateY(14px)}to{opacity:1;transform:scale(1) translateY(0)}}
.mhd{padding:20px 24px 14px;border-bottom:1px solid var(--b);
  display:flex;align-items:center;justify-content:space-between}
.mttl{font-size:16px;font-weight:700}
.mbdy{padding:20px 24px 28px}
.mcls{background:none;border:none;color:var(--t2);cursor:pointer;font-size:22px;
  line-height:1;transition:color .2s;padding:0}
.mcls:hover{color:var(--t1)}

#toasts{position:fixed;top:20px;right:20px;z-index:200;display:flex;
  flex-direction:column;gap:8px;pointer-events:none}
.toast{background:var(--surface);border:1px solid var(--b);border-radius:10px;
  padding:11px 16px;font-size:13.5px;font-weight:500;display:flex;align-items:center;
  gap:9px;min-width:260px;max-width:360px;pointer-events:all;box-shadow:0 8px 40px rgba(0,0,0,.5);
  animation:tIn .3s var(--ease)}
.toast.ok{border-left:3px solid var(--green)}.toast.err{border-left:3px solid var(--red)}
.toast.inf{border-left:3px solid var(--indigo)}
@keyframes tIn{from{opacity:0;transform:translateX(20px)}to{opacity:1;transform:translateX(0)}}

#ldr{position:fixed;inset:0;background:rgba(8,12,20,.85);backdrop-filter:blur(4px);
  z-index:300;display:none;align-items:center;justify-content:center;flex-direction:column;gap:14px}
#ldr.on{display:flex}
.ldr-ring{width:42px;height:42px;border:3px solid var(--b);border-top-color:var(--green);
  border-radius:50%;animation:spin .75s linear infinite}
.ldr-txt{font-size:13px;color:var(--t2)}
@keyframes spin{to{transform:rotate(360deg)}}

.chw{position:relative;height:210px}
.chw canvas{max-height:210px}
.fbar{display:flex;gap:8px;margin-bottom:16px;flex-wrap:wrap}
.fbar .inp{flex:0 0 auto;width:auto;min-width:150px}
.card-actions{display:flex;gap:8px;margin-top:12px;justify-content:flex-end}

.av-edit{position:relative;width:88px;height:88px;margin:0 auto 8px;border-radius:50%;
  overflow:hidden;background:linear-gradient(135deg,var(--green),var(--indigo));
  display:flex;align-items:center;justify-content:center;font-size:32px;font-weight:800;
  color:#040a06;background-size:cover;background-position:center;cursor:pointer}
.av-edit::after{content:'📷';position:absolute;inset:0;background:rgba(0,0,0,.5);
  display:flex;align-items:center;justify-content:center;font-size:22px;opacity:0;transition:opacity .2s}
.av-edit:hover::after{opacity:1}

@media(prefers-reduced-motion:reduce){
  *,*::before,*::after{animation-duration:.001ms!important;transition-duration:.001ms!important}
}

/* ══════════════ PAINEL DE INVESTIMENTOS (IPCA+) ══════════════ */
/* Hero */
.ip-hero{position:relative;overflow:hidden;border-radius:var(--rl);padding:22px 24px;margin-bottom:18px;
  background:linear-gradient(135deg,rgba(34,197,94,.14),rgba(56,189,248,.10) 55%,rgba(129,140,248,.14));
  border:1px solid rgba(255,255,255,.08);box-shadow:0 10px 40px -16px rgba(0,0,0,.7)}
.ip-hero-glow{position:absolute;inset:0;pointer-events:none;
  background:radial-gradient(ellipse 60% 120% at 15% 0%,rgba(34,197,94,.22),transparent 60%),
             radial-gradient(ellipse 50% 120% at 90% 100%,rgba(129,140,248,.20),transparent 60%);
  animation:ipGlow 8s ease-in-out infinite alternate}
@keyframes ipGlow{0%{opacity:.6;transform:translateX(0)}100%{opacity:1;transform:translateX(6px)}}
.ip-hero-title{font-size:19px;font-weight:800;letter-spacing:-.3px;
  background:linear-gradient(135deg,#fff,#cbd5e1);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent}
.ip-hero-sub{font-size:12.5px;color:var(--t2);margin-top:4px}
.ip-countdown{display:inline-flex;align-items:center;gap:6px;padding:6px 13px;border-radius:20px;
  font-size:12px;font-weight:700;color:#fff;
  background:linear-gradient(135deg,rgba(34,197,94,.35),rgba(56,189,248,.35));
  border:1px solid rgba(255,255,255,.14);box-shadow:0 0 20px -4px rgba(34,197,94,.5)}

/* Plano / inputs */
.ip-plan{background:linear-gradient(180deg,rgba(255,255,255,.045),rgba(255,255,255,.02));
  box-shadow:0 6px 26px -12px rgba(0,0,0,.5)}
.ip-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(158px,1fr));gap:14px}
.ip-field{display:flex;flex-direction:column;gap:0}
.ip-field .lbl{margin-bottom:7px}
.ip-inputwrap{position:relative}
.ip-suffix{position:absolute;right:13px;top:50%;transform:translateY(-50%);
  font-size:11px;font-weight:700;color:var(--t3);pointer-events:none;transition:color .2s}
.ipca-fld{transition:border-color .2s,box-shadow .2s,background .2s,transform .12s!important}
.ipca-fld:focus{border-color:var(--green)!important;
  box-shadow:0 0 0 3px var(--gd),0 0 22px -4px rgba(34,197,94,.45)!important}
.ip-field:focus-within .ip-suffix{color:var(--green)}
.ip-field:focus-within .lbl{color:var(--green)}
.ip-ratehint{font-size:11.5px;color:var(--t3);margin-top:14px;line-height:1.7;
  padding:11px 13px;border-radius:10px;background:rgba(245,158,11,.06);border:1px solid rgba(245,158,11,.12)}

/* Cards de estatística coloridos */
.ip-stats{display:grid;grid-template-columns:repeat(auto-fit,minmax(155px,1fr));gap:12px}
.ip-stat{position:relative;overflow:hidden;padding:16px 16px 15px;border-radius:14px;
  background:linear-gradient(180deg,rgba(255,255,255,.05),rgba(255,255,255,.02));
  border:1px solid var(--b);transition:transform .25s var(--ease),box-shadow .25s var(--ease),border-color .25s}
.ip-stat::before{content:'';position:absolute;left:0;top:0;bottom:0;width:3px;background:var(--t3);opacity:.8}
.ip-stat:hover{transform:translateY(-3px);box-shadow:0 14px 34px -14px rgba(0,0,0,.6)}
.ip-stat-lbl{font-size:10.5px;font-weight:700;color:var(--t2);text-transform:uppercase;letter-spacing:.06em;margin-bottom:7px}
.ip-stat-val{font-family:var(--m);font-size:18px;font-weight:700;line-height:1.1}
.ip-stat-sub{font-size:11px;color:var(--t3);margin-top:5px}
.ip-stat.s-green::before{background:var(--green);box-shadow:0 0 14px var(--green)}
.ip-stat.s-green .ip-stat-val{color:var(--green)}
.ip-stat.s-indigo::before{background:var(--indigo);box-shadow:0 0 14px var(--indigo)}
.ip-stat.s-indigo .ip-stat-val{color:var(--indigo)}
.ip-stat.s-amber::before{background:var(--amber);box-shadow:0 0 14px var(--amber)}
.ip-stat.s-amber .ip-stat-val{color:var(--amber)}
.ip-stat.s-red::before{background:var(--red);box-shadow:0 0 14px var(--red)}
.ip-stat.s-red .ip-stat-val{color:var(--red)}
.ip-stat.s-neutral .ip-stat-val{color:var(--t1)}
.ip-stat.s-neutral::before{background:linear-gradient(var(--green),var(--indigo))}

/* Valor de hoje em destaque */
.ip-today{background:linear-gradient(135deg,rgba(129,140,248,.08),rgba(34,197,94,.05));
  border:1px solid rgba(129,140,248,.16)}
.ip-today-val{font-family:var(--m);font-size:22px;font-weight:800;margin-top:2px;
  background:linear-gradient(135deg,#818cf8,#a5b4fc);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent}

/* Tabelas */
.ip-tablecard table th{position:sticky;top:0}
.ip-tablecard tbody tr{transition:background .15s}
.ip-tablecard tbody tr:hover{background:rgba(255,255,255,.03)}

@media(max-width:600px){
  .ip-grid{grid-template-columns:1fr 1fr}
  .ip-hero{padding:18px}
  .ip-hero-title{font-size:16px}
}
</style>
</head>
<body>

<div class="orbs"><div class="orb o1"></div><div class="orb o2"></div><div class="orb o3"></div></div>
<div id="toasts"></div>
<div id="ldr"><div class="ldr-ring"></div><div class="ldr-txt" id="ldr-txt">Carregando...</div></div>

<!-- ════════════ TELA: LOGIN / CADASTRO / RECUPERAR SENHA ════════════ -->
<div id="sc-auth" class="screen">
  <div class="auth-left">
    <div class="al-logo">💰 FinanceFlow</div>
    <div class="al-tag">Gestão financeira pessoal</div>
    <div class="al-heading">Controle total das suas <span>finanças.</span></div>
    <p class="al-desc">Registre seu salário, acompanhe gastos, invista melhor e quite suas dívidas com clareza.</p>
    <div class="al-features">
      <div class="al-feat"><span>💰</span> Gestão completa do salário mensal</div>
      <div class="al-feat"><span>📊</span> Gráficos e histórico de gastos</div>
      <div class="al-feat"><span>📈</span> Controle de investimentos</div>
      <div class="al-feat"><span>💳</span> Tracker de dívidas e parcelas</div>
    </div>
  </div>
  <div class="auth-right">
    <div class="ar-logo">💰 FinanceFlow</div>
    <div class="auth-tabs">
      <button class="atab active" data-tab="login" type="button">Entrar</button>
      <button class="atab" data-tab="register" type="button">Criar conta</button>
    </div>

    <!-- LOGIN -->
    <form class="auth-form active" id="af-login" novalidate autocomplete="on">
      <div id="login-err" class="auth-err" role="alert"></div>
      <div class="inp-wrap">
        <label for="l-email">E-mail</label>
        <span class="ico">✉</span>
        <input type="email" id="l-email" autocomplete="email" placeholder="seu@email.com" required/>
      </div>
      <div class="inp-wrap">
        <label for="l-pass">Senha</label>
        <span class="ico">🔒</span>
        <input type="password" id="l-pass" autocomplete="current-password" placeholder="••••••••" required/>
      </div>
      <button class="btn btn-g btn-full" id="l-btn" type="submit">Entrar na minha conta →</button>
      <div class="auth-foot"><button class="auth-link" type="button" data-goto="recover">Esqueci minha senha</button></div>
    </form>

    <!-- REGISTER -->
    <form class="auth-form" id="af-register" novalidate autocomplete="on">
      <div id="reg-err" class="auth-err" role="alert"></div>
      <div id="reg-ok" class="auth-ok" role="status"></div>
      <div class="inp-wrap">
        <label for="r-name">Seu nome</label>
        <span class="ico">👤</span>
        <input type="text" id="r-name" autocomplete="name" placeholder="João Silva"/>
      </div>
      <div class="inp-wrap">
        <label for="r-email">E-mail</label>
        <span class="ico">✉</span>
        <input type="email" id="r-email" autocomplete="email" placeholder="seu@email.com" required/>
        <div class="inp-hint" id="r-email-hint"></div>
      </div>
      <div class="inp-wrap">
        <label for="r-pass">Senha (mínimo 6 caracteres)</label>
        <span class="ico">🔒</span>
        <input type="password" id="r-pass" autocomplete="new-password" placeholder="••••••••" required/>
        <div class="inp-hint" id="r-pass-hint"></div>
      </div>
      <button class="btn btn-g btn-full" id="r-btn" type="submit">Criar minha conta →</button>
    </form>

    <!-- RECOVER -->
    <form class="auth-form" id="af-recover" novalidate>
      <div id="rec-err" class="auth-err" role="alert"></div>
      <div id="rec-ok" class="auth-ok" role="status"></div>
      <p class="al-desc" style="font-size:13.5px;margin-bottom:18px">Informe seu e-mail e enviaremos um link para você criar uma nova senha.</p>
      <div class="inp-wrap">
        <label for="rec-email">E-mail</label>
        <span class="ico">✉</span>
        <input type="email" id="rec-email" autocomplete="email" placeholder="seu@email.com" required/>
      </div>
      <button class="btn btn-g btn-full" id="rec-btn" type="submit">Enviar link de recuperação</button>
      <div class="auth-foot"><button class="auth-link" type="button" data-goto="login">← Voltar ao login</button></div>
    </form>
  </div>
</div>

<!-- ════════════ APP SCREEN ════════════ -->
<div id="sc-app" class="screen">
  <aside class="sb">
    <div class="sb-logo">Finance<em>Flow</em></div>
    <div class="sb-sec">Menu</div>
    <nav class="sb-nav" id="sb-nav"></nav>
    <div class="sb-foot">
      <div class="sb-av" id="sb-av" title="Editar perfil">U</div>
      <div class="sb-ui" id="sb-profile-open" title="Editar perfil">
        <div class="sb-name" id="sb-name">—</div>
        <div class="sb-email" id="sb-email">—</div>
      </div>
      <button class="sb-out" id="sb-logout" type="button" title="Sair">
        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
      </button>
    </div>
  </aside>

  <main class="main">
    <div class="mhdr">
      <div>
        <h1 id="ph-t">Dashboard</h1>
        <div class="mhdr-sub" id="ph-s">Visão geral</div>
      </div>
      <div class="mhdr-right">
        <div class="mnav" id="mnav" title="Navegar entre meses">
          <button class="mnav-btn" id="mnav-prev" type="button" aria-label="Mês anterior">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="15 18 9 12 15 6"/></svg>
          </button>
          <button class="mnav-label" id="mnav-label" type="button" title="Voltar ao mês atual">Julho 2026</button>
          <button class="mnav-btn" id="mnav-next" type="button" aria-label="Próximo mês">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="9 18 15 12 9 6"/></svg>
          </button>
        </div>
        <div id="ph-a"></div>
      </div>
    </div>
    <div class="mcontent">

      <!-- DASHBOARD -->
      <div class="page on" id="pg-dashboard">
        <div class="g4" style="margin-bottom:14px">
          <div class="card"><div class="card-bar bar-g"></div><div class="card-lbl">Salário do mês</div><div class="card-val" id="d-sal">R$ 0,00</div><div class="card-sub" id="d-mes">—</div></div>
          <div class="card"><div class="card-bar bar-g"></div><div class="card-lbl">Total entradas</div><div class="card-val" id="d-inc">R$ 0,00</div><div class="card-sub">Este mês</div></div>
          <div class="card"><div class="card-bar bar-r"></div><div class="card-lbl">Total saídas</div><div class="card-val" id="d-exp">R$ 0,00</div><div class="card-sub">Este mês</div></div>
          <div class="card"><div class="card-bar bar-i"></div><div class="card-lbl">Saldo livre</div><div class="card-val" id="d-bal">R$ 0,00</div><div class="card-sub">Não distribuído</div></div>
        </div>
        <div class="g4" style="margin-bottom:14px">
          <div class="card"><div class="card-bar bar-i"></div><div class="card-lbl">Investido no mês</div><div class="card-val" id="d-inv">R$ 0,00</div></div>
          <div class="card"><div class="card-bar bar-a"></div><div class="card-lbl">Reservado no mês</div><div class="card-val" id="d-res">R$ 0,00</div></div>
          <div class="card"><div class="card-bar bar-i"></div><div class="card-lbl">Patrimônio investido</div><div class="card-val" id="d-patr">R$ 0,00</div><div class="card-sub" id="d-patr-r">—</div></div>
          <div class="card"><div class="card-bar bar-r"></div><div class="card-lbl">Dívidas em aberto</div><div class="card-val" id="d-debt">R$ 0,00</div><div class="card-sub" id="d-debt-p">—</div></div>
        </div>
        <div class="gch" style="margin-bottom:14px">
          <div class="card">
            <div class="sec" style="margin-top:0;margin-bottom:14px"><h2>Distribuição</h2><span class="badge bs" id="d-dlbl">—</span></div>
            <div class="chw"><canvas id="ch-donut"></canvas></div>
            <div id="ch-leg" style="margin-top:12px;display:flex;flex-direction:column;gap:5px"></div>
          </div>
          <div class="card">
            <div class="sec" style="margin-top:0;margin-bottom:14px"><h2>Histórico — 6 meses</h2><span class="badge bg">Salário × Saídas</span></div>
            <div class="chw"><canvas id="ch-bar"></canvas></div>
          </div>
        </div>
        <div class="sec"><h2>Movimentos recentes</h2><button class="btn btn-o btn-sm" data-nav="movements" type="button">Ver todos →</button></div>
        <div id="d-recent"></div>
      </div>

      <!-- SALARY -->
      <div class="page" id="pg-salary"><div id="salary-list"></div></div>

      <!-- MOVEMENTS -->
      <div class="page" id="pg-movements">
        <div class="fbar">
          <input class="inp" id="mf-q" type="search" placeholder="🔍 Buscar descrição..." style="min-width:200px"/>
          <select class="inp" id="mf-m"><option value="">Todos os meses</option></select>
          <select class="inp" id="mf-t">
            <option value="">Todos os tipos</option><option value="entrada">💚 Entradas</option>
            <option value="saida">🔴 Saídas</option><option value="investimento">🔵 Investimentos</option>
            <option value="reserva">🟡 Reservas</option>
          </select>
          <select class="inp" id="mf-c"><option value="">Todas categorias</option></select>
          <select class="inp" id="mf-sort">
            <option value="date-desc">Mais recentes</option>
            <option value="date-asc">Mais antigos</option>
            <option value="amount-desc">Maior valor</option>
            <option value="amount-asc">Menor valor</option>
          </select>
        </div>
        <div id="mov-list"></div>
        <div id="mov-pager" style="display:flex;justify-content:center;gap:8px;margin-top:14px"></div>
        <div id="mov-tot" style="margin-top:10px;text-align:right;font-size:13px;color:var(--t2)"></div>
      </div>

      <!-- INVESTMENTS -->
      <div class="page" id="pg-investments">
        <div id="inv-list"></div>
      </div>

      <!-- DEBTS -->
      <div class="page" id="pg-debts">
        <div class="g3" style="margin-bottom:14px">
          <div class="card"><div class="card-bar bar-r"></div><div class="card-lbl">Restante a pagar</div><div class="card-val" id="db-tot">R$ 0,00</div></div>
          <div class="card"><div class="card-bar bar-a"></div><div class="card-lbl">Parcelas pendentes</div><div class="card-val" id="db-pend">0</div></div>
          <div class="card"><div class="card-bar bar-a"></div><div class="card-lbl">Próximo vencimento</div><div class="card-val" id="db-next" style="font-size:16px">—</div><div class="card-sub" id="db-next-d">—</div></div>
        </div>
        <div id="dbt-list"></div>
      </div>

    </div>
  </main>
</div>

<!-- MODAL -->
<div id="mbg">
  <div id="mbox" role="dialog" aria-modal="true">
    <div class="mhd"><div class="mttl" id="m-ttl">—</div><button class="mcls" id="m-close" type="button" aria-label="Fechar">×</button></div>
    <div class="mbdy" id="m-bdy"></div>
  </div>
</div>
<input type="file" id="av-file" accept="image/png,image/jpeg,image/webp" style="display:none"/>

<script>
'use strict';
/* ══════════════════════════════════════════════════════════════
   CONFIGURAÇÃO DO SUPABASE — definida apenas pelo desenvolvedor.
   O usuário final NUNCA vê nem informa esses valores.
   Substitua pelos dados do SEU projeto antes de publicar.
══════════════════════════════════════════════════════════════ */
const SUPABASE_URL      = "https://ejdboszoswqvgsjsrcmf.supabase.co";
const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVqZGJvc3pvc3dxdmdzanNyY21mIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODI1ODI2NzcsImV4cCI6MjA5ODE1ODY3N30.eK7FeZ9N8WabTR6UcLN9XSz6zXl4jLc_NW_FimMUX9M";

/* ══════════════════════════════════════════════════════════════
   CONSTANTES
══════════════════════════════════════════════════════════════ */
const MO=['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'];
const CATS={
  moradia:{l:'Moradia',e:'🏠',c:'#818cf8'}, alimentacao:{l:'Alimentação',e:'🍽️',c:'#fb923c'},
  transporte:{l:'Transporte',e:'🚗',c:'#38bdf8'}, saude:{l:'Saúde',e:'💊',c:'#22c55e'},
  lazer:{l:'Lazer',e:'🎮',c:'#e879f9'}, familia:{l:'Família',e:'👨‍👩‍👧',c:'#f472b6'},
  investimento:{l:'Investimento',e:'📈',c:'#818cf8'}, dividas:{l:'Dívidas',e:'💳',c:'#ef4444'},
  reservas:{l:'Reservas',e:'🐖',c:'#f59e0b'}, celular:{l:'Celular/Internet',e:'📱',c:'#38bdf8'},
  outros:{l:'Outros',e:'📦',c:'#64748b'},
};
const TMAP={entrada:'Entrada',saida:'Saída',investimento:'Investimento',reserva:'Reserva'};
const TCLS={entrada:'bg',saida:'br',investimento:'bi',reserva:'ba'};
const PAGE_SIZE=15;

/* ══════════════════════════════════════════════════════════════
   PERSISTÊNCIA LOCAL — apenas a sessão do usuário (padrão de
   qualquer app logado). Não expõe configuração ao usuário.
══════════════════════════════════════════════════════════════ */
const LS={
  g(k){try{return JSON.parse(localStorage.getItem('ff_'+k))}catch{return null}},
  s(k,v){try{localStorage.setItem('ff_'+k,JSON.stringify(v))}catch{}},
  d(k){try{localStorage.removeItem('ff_'+k)}catch{}},
};
let SES=LS.g('session');
function saveSes(){SES?LS.s('session',SES):LS.d('session')}
function clearSes(){SES=null;LS.d('session')}

/* ══════════════════════════════════════════════════════════════
   ESTADO DO APP  (com cache + controle de "sujeira")
══════════════════════════════════════════════════════════════ */
const ST={
  page:'dashboard',
  months:[],movs:[],invs:[],debts:[],contribs:[],
  profile:null,
  sel:null,               // {m, y} — mês/ano atualmente selecionado na navegação
  loaded:false,          // dados já sincronizados nesta sessão?
  syncing:null,          // promessa de sync em andamento (evita corridas)
  mov:{page:1},          // paginação da tela de movimentos
};

/* ══════════════════════════════════════════════════════════════
   SEGURANÇA — escape de HTML (previne XSS armazenado)
══════════════════════════════════════════════════════════════ */
const esc=s=>String(s==null?'':s).replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));

/* ══════════════════════════════════════════════════════════════
   MENSAGENS AMIGÁVEIS — traduz erros técnicos
══════════════════════════════════════════════════════════════ */
function friendly(e){
  const m=((e&&e.message)||'').toLowerCase();
  if(m.includes('failed to fetch')||m.includes('networkerror')) return 'Sem conexão. Verifique sua internet.';
  if(m.includes('invalid')&&m.includes('credential'))            return 'E-mail ou senha incorretos.';
  if(m.includes('email not confirmed')||m.includes('confirm'))   return 'Confirme seu e-mail antes de entrar.';
  if(m.includes('already')||m.includes('registered')||m.includes('exists')) return 'Este e-mail já está cadastrado.';
  if(m.includes('jwt')||m.includes('expired')||m.includes('token')) return 'Sua sessão expirou. Faça login novamente.';
  if(m.includes('duplicate')||m.includes('unique'))              return 'Esse registro já existe.';
  if(m.includes('password')&&m.includes('6'))                    return 'A senha deve ter pelo menos 6 caracteres.';
  return 'Algo deu errado. Tente novamente em instantes.';
}

/* ══════════════════════════════════════════════════════════════
   CAMADA SUPABASE (REST + Auth + Storage)
══════════════════════════════════════════════════════════════ */
const SB={
  async call(path,opts={}){
    const h={'apikey':SUPABASE_ANON_KEY,'Content-Type':'application/json'};
    if(!opts.noAuth&&SES?.access_token)h['Authorization']='Bearer '+SES.access_token;
    if(opts.prefer)h['Prefer']=opts.prefer;
    let r;
    try{
      r=await fetch(SUPABASE_URL+path,{method:opts.method||'GET',headers:h,
        body:opts.body!==undefined?JSON.stringify(opts.body):undefined});
    }catch(netErr){throw new Error('Failed to fetch')}
    if(!r.ok){
      let e={};try{e=await r.json()}catch{}
      const err=new Error(e.error_description||e.msg||e.message||e.error||('HTTP '+r.status));
      err.status=r.status;throw err;
    }
    const t=await r.text();return t?JSON.parse(t):null;
  },
  signUp:(email,pass,name)=>SB.call('/auth/v1/signup',{noAuth:true,method:'POST',body:{email,password:pass,data:{name}}}),
  signIn:(email,pass)=>SB.call('/auth/v1/token?grant_type=password',{noAuth:true,method:'POST',body:{email,password:pass}}),
  refresh:(rt)=>SB.call('/auth/v1/token?grant_type=refresh_token',{noAuth:true,method:'POST',body:{refresh_token:rt}}),
  recover:(email,redirect)=>SB.call('/auth/v1/recover',{noAuth:true,method:'POST',body:{email,redirect_to:redirect}}),
  updateUser:(body)=>SB.call('/auth/v1/user',{method:'PUT',body}),
  get:(t,q='')=>SB.call('/rest/v1/'+t+(q?'?'+q+'&':'?')+'order=created_at.desc').then(r=>r||[]),
  ins:(t,d)=>SB.call('/rest/v1/'+t,{method:'POST',prefer:'return=representation',body:d}),
  upsert:(t,d,onConflict)=>SB.call('/rest/v1/'+t+'?on_conflict='+encodeURIComponent(onConflict),{method:'POST',prefer:'resolution=merge-duplicates,return=representation',body:d}),
  upd:(t,id,d)=>SB.call('/rest/v1/'+t+'?id=eq.'+encodeURIComponent(id),{method:'PATCH',prefer:'return=representation',body:d}),
  del:(t,id)=>SB.call('/rest/v1/'+t+'?id=eq.'+encodeURIComponent(id),{method:'DELETE'}),
  upsertProfile:(d)=>SB.call('/rest/v1/profiles',{method:'POST',prefer:'resolution=merge-duplicates,return=representation',body:d}),
  getContribs:(invId)=>SB.call('/rest/v1/investment_contributions?investment_id=eq.'+encodeURIComponent(invId)+'&order=contribution_date.desc,created_at.desc').then(r=>r||[]),
  async uploadAvatar(userId,file){
    const ext=(file.name.split('.').pop()||'png').toLowerCase();
    const path=userId+'/avatar_'+Date.now()+'.'+ext;
    const r=await fetch(SUPABASE_URL+'/storage/v1/object/avatars/'+path,{
      method:'POST',
      headers:{'apikey':SUPABASE_ANON_KEY,'Authorization':'Bearer '+SES.access_token,'Content-Type':file.type||'image/png','x-upsert':'true'},
      body:file
    });
    if(!r.ok)throw new Error('upload failed');
    return SUPABASE_URL+'/storage/v1/object/public/avatars/'+path;
  },
};

/* ══════════════════════════════════════════════════════════════
   HELPERS DE UI
══════════════════════════════════════════════════════════════ */
const $=id=>document.getElementById(id);
const fmt=v=>'R$ '+Number(v||0).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2});
const ml=(m,y)=>MO[(m||1)-1]+' / '+y;
const uid=()=>SES?.user?.id||null;
const isEmail=e=>/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(e);

function ldr(on=true,txt='Carregando...'){$('ldr').classList.toggle('on',on);$('ldr-txt').textContent=txt}
function toast(msg,type='ok'){
  const ico={ok:'✅',err:'❌',inf:'ℹ️'};
  const el=document.createElement('div');
  el.className='toast '+type;
  el.innerHTML='<span>'+(ico[type]||'•')+'</span><span></span>';
  el.lastChild.textContent=msg;            // textContent => sem XSS
  $('toasts').appendChild(el);
  setTimeout(()=>{el.style.transition='all .3s';el.style.opacity='0';el.style.transform='translateX(20px)';
    setTimeout(()=>el.remove(),300)},3800);
}
function showSc(id){
  document.querySelectorAll('.screen').forEach(s=>s.classList.remove('active'));
  $('sc-'+id).classList.add('active');
}
function openModal(title,html){
  $('m-ttl').textContent=title;
  $('m-bdy').innerHTML=html;
  $('mbg').classList.add('open');
  const first=$('m-bdy').querySelector('input,select,textarea,button');
  if(first)setTimeout(()=>first.focus(),50);
}
function closeModal(){$('mbg').classList.remove('open')}

/* Animação de número — cancela a anterior no mesmo elemento (sem corrida) */
const animRegistry=new WeakMap();
function animV(el,target,dur=800){
  if(!el)return;
  const prev=animRegistry.get(el);if(prev)cancelAnimationFrame(prev);
  const start=performance.now(),from=0;
  const step=t=>{
    const p=Math.min((t-start)/dur,1),e=1-Math.pow(1-p,3),c=from+(target-from)*e;
    el.textContent=fmt(c);
    if(p<1)animRegistry.set(el,requestAnimationFrame(step));else animRegistry.delete(el);
  };
  animRegistry.set(el,requestAnimationFrame(step));
}

/* ══════════════════════════════════════════════════════════════
   AUTENTICAÇÃO
══════════════════════════════════════════════════════════════ */
function authTab(tab){
  document.querySelectorAll('.atab').forEach(b=>b.classList.toggle('active',b.dataset.tab===tab));
  showForm(tab);
}
function showForm(name){
  document.querySelectorAll('.auth-form').forEach(f=>f.classList.remove('active'));
  $('af-'+name).classList.add('active');
  ['login-err','reg-err','reg-ok','rec-err','rec-ok'].forEach(id=>{const e=$(id);if(e)e.style.display='none'});
}
function showMsg(id,msg,show=true){const el=$(id);if(!el)return;el.textContent=msg;el.style.display=show?'block':'none'}
function setBtn(id,loading,label){
  const b=$(id);if(!b)return;
  b.disabled=loading;
  if(loading){b.dataset.label=b.textContent;b.textContent='Aguarde...'}
  else b.textContent=label||b.dataset.label||b.textContent;
}
function setSessionFromAuth(r){
  SES={access_token:r.access_token,refresh_token:r.refresh_token,
    expires_at:Date.now()+(r.expires_in||3600)*1000,user:r.user};
  saveSes();scheduleRefresh();
}

async function doLogin(e){
  e&&e.preventDefault();
  const email=$('l-email').value.trim(),pass=$('l-pass').value;
  showMsg('login-err','',false);
  if(!email||!pass){showMsg('login-err','Preencha e-mail e senha.');return}
  if(!isEmail(email)){showMsg('login-err','Informe um e-mail válido.');return}
  setBtn('l-btn',true);
  try{
    setSessionFromAuth(await SB.signIn(email,pass));
    await enterApp();
    toast('Bem-vindo de volta! 👋');
  }catch(err){showMsg('login-err',friendly(err))}
  setBtn('l-btn',false,'Entrar na minha conta →');
}

async function doRegister(e){
  e&&e.preventDefault();
  const name=$('r-name').value.trim(),email=$('r-email').value.trim(),pass=$('r-pass').value;
  showMsg('reg-err','',false);showMsg('reg-ok','',false);
  if(!isEmail(email)){showMsg('reg-err','Informe um e-mail válido.');return}
  if(pass.length<6){showMsg('reg-err','A senha deve ter pelo menos 6 caracteres.');return}
  setBtn('r-btn',true);
  try{
    const r=await SB.signUp(email,pass,name||email.split('@')[0]);
    if(r?.access_token){
      setSessionFromAuth(r);
      await enterApp();
      toast('Conta criada com sucesso! Bem-vindo 🎉');
    }else{
      const ok=$('reg-ok');
      ok.textContent='';
      ok.append('📧 Quase lá! Enviamos um link de confirmação para '+email+'. Após confirmar, volte e faça login.');
      ok.style.display='block';
    }
  }catch(err){showMsg('reg-err',friendly(err))}
  setBtn('r-btn',false,'Criar minha conta →');
}

async function doRecover(e){
  e&&e.preventDefault();
  const email=$('rec-email').value.trim();
  showMsg('rec-err','',false);showMsg('rec-ok','',false);
  if(!isEmail(email)){showMsg('rec-err','Informe um e-mail válido.');return}
  setBtn('rec-btn',true);
  try{
    await SB.recover(email,location.origin+location.pathname);
    showMsg('rec-ok','Se este e-mail estiver cadastrado, o link de recuperação foi enviado. Verifique sua caixa de entrada.');
  }catch(err){
    // Por segurança não revelamos se o e-mail existe: mostramos sucesso genérico
    showMsg('rec-ok','Se este e-mail estiver cadastrado, o link de recuperação foi enviado.');
  }
  setBtn('rec-btn',false,'Enviar link de recuperação');
}

function doLogout(){
  clearSes();
  ST.months=[];ST.movs=[];ST.invs=[];ST.debts=[];ST.contribs=[];ST.profile=null;ST.loaded=false;ST.syncing=null;ST.sel=null;
  destroyCharts();
  if(refreshTimer){clearTimeout(refreshTimer);refreshTimer=null}
  $('l-email').value='';$('l-pass').value='';
  authTab('login');showSc('auth');
}

/* Refresh proativo agendado — mantém a sessão viva sem o usuário perceber */
let refreshTimer=null;
function scheduleRefresh(){
  if(refreshTimer)clearTimeout(refreshTimer);
  if(!SES?.expires_at)return;
  const wait=Math.max(SES.expires_at-Date.now()-60000,5000); // 1 min antes de expirar
  refreshTimer=setTimeout(async()=>{await refreshToken()},wait);
}
let refreshing=null;
async function refreshToken(){
  if(refreshing)return refreshing;                 // evita múltiplos refresh simultâneos
  if(!SES?.refresh_token)return false;
  refreshing=(async()=>{
    try{
      const r=await SB.refresh(SES.refresh_token);
      SES.access_token=r.access_token;
      SES.refresh_token=r.refresh_token||SES.refresh_token;
      SES.expires_at=Date.now()+(r.expires_in||3600)*1000;
      if(r.user)SES.user=r.user;
      saveSes();scheduleRefresh();return true;
    }catch{return false}
    finally{refreshing=null}
  })();
  return refreshing;
}
async function ensureSession(){
  if(SES?.expires_at&&Date.now()>SES.expires_at-60000){
    const ok=await refreshToken();
    if(!ok){toast('Sua sessão expirou. Faça login novamente.','err');doLogout();return false}
  }
  return true;
}

/* ══════════════════════════════════════════════════════════════
   PERFIL
══════════════════════════════════════════════════════════════ */
function displayName(){
  return ST.profile?.full_name || SES?.user?.user_metadata?.name || SES?.user?.email?.split('@')[0] || 'Usuário';
}
function avatarUrl(){
  return ST.profile?.avatar_url || SES?.user?.user_metadata?.avatar_url || '';
}
function paintProfile(){
  const name=displayName(),url=avatarUrl(),av=$('sb-av');
  $('sb-name').textContent=name;
  $('sb-email').textContent=SES?.user?.email||'';
  if(url){av.style.backgroundImage='url("'+url+'")';av.textContent=''}
  else{av.style.backgroundImage='';av.textContent=name.charAt(0).toUpperCase()}
}
async function loadProfile(){
  try{
    const rows=await SB.get('profiles','id=eq.'+uid());
    ST.profile=rows?.[0]||null;
    if(!ST.profile){ // fallback: cria perfil caso a trigger não tenha rodado
      const created=await SB.upsertProfile({id:uid(),full_name:displayName()});
      ST.profile=created?.[0]||{id:uid(),full_name:displayName()};
    }
  }catch{ST.profile=null}
  paintProfile();
}

async function enterApp(){
  paintProfile();
  showSc('app');
  buildNav();
  await Promise.all([loadProfile(),sync(true)]);
  await schemaSelfTest();    // verifica se o banco está completo e avisa se faltar algo
  initSelectedMonth();       // define o mês inicial (último visto ou atual)
  paintMonthLabel();
  await nav('dashboard');
}

/* Verifica, uma vez por sessão, se as tabelas essenciais existem.
   Se algo faltar, mostra um aviso claro em vez de o app "engolir" os dados. */
let _schemaChecked=false;
async function schemaSelfTest(){
  if(_schemaChecked)return;_schemaChecked=true;
  const tables=['salary_months','movements','investments','debts','investment_contributions'];
  const results=await Promise.allSettled(
    tables.map(t=>SB.call('/rest/v1/'+t+'?select=id&limit=1'))
  );
  const missing=tables.filter((t,i)=>results[i].status==='rejected');
  if(missing.length){
    toast('Banco incompleto: falta a tabela "'+missing[0]+'". Rode o SQL de instalação no Supabase.','err');
  }
}

/* ══════════════════════════════════════════════════════════════
   NAVEGAÇÃO
══════════════════════════════════════════════════════════════ */
const NAV=[
  {id:'dashboard',t:'Dashboard',s:'Visão geral das suas finanças',a:null,
    ico:'<rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/>'},
  {id:'salary',t:'Salário',s:'Salário e resumo do mês selecionado',
    ico:'<path d="M12 2v20M17 5H9.5a3.5 3.5 0 000 7h5a3.5 3.5 0 010 7H6"/>'},
  {id:'movements',t:'Movimentos',s:'Entradas, saídas, reservas e investimentos',act:'openAddMov',aLabel:'+ Movimento',
    ico:'<line x1="8" y1="6" x2="21" y2="6"/><line x1="8" y1="12" x2="21" y2="12"/><line x1="8" y1="18" x2="21" y2="18"/><circle cx="3.5" cy="6" r="1.5" fill="currentColor"/><circle cx="3.5" cy="12" r="1.5" fill="currentColor"/><circle cx="3.5" cy="18" r="1.5" fill="currentColor"/>'},
  {id:'investments',t:'Investimentos',s:'Planejador Tesouro IPCA+ 2032',
    ico:'<polyline points="22 7 13.5 15.5 8.5 10.5 2 17"/><polyline points="16 7 22 7 22 13"/>'},
  {id:'debts',t:'Dívidas',s:'Parcelas e pagamentos',act:'openAddDebt',aLabel:'+ Nova dívida',
    ico:'<rect x="1" y="4" width="22" height="16" rx="2"/><line x1="1" y1="10" x2="23" y2="10"/>'},
];
function buildNav(){
  $('sb-nav').innerHTML=NAV.map(n=>
    '<div class="sb-item'+(n.id==='dashboard'?' on':'')+'" data-nav="'+n.id+'" role="button" tabindex="0">'+
    '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">'+n.ico+'</svg>'+
    '<span class="sb-txt">'+n.t+'</span></div>').join('');
}
async function nav(page){
  const meta=NAV.find(n=>n.id===page);if(!meta)return;
  ST.page=page;
  document.querySelectorAll('.sb-item').forEach(el=>el.classList.toggle('on',el.dataset.nav===page));
  document.querySelectorAll('.page').forEach(p=>p.classList.remove('on'));
  $('pg-'+page).classList.add('on');
  $('ph-t').textContent=meta.t;
  $('ph-s').textContent=meta.s;
  $('ph-a').innerHTML=meta.act?'<button class="btn btn-g" data-act="'+meta.act+'" type="button">'+esc(meta.aLabel)+'</button>':'';
  toggleMonthNav(page);
  await loadPage(page);
}
async function loadPage(p){
  const fn={dashboard:renderDash,salary:renderSalary,movements:renderMovPage,investments:renderInvPage,debts:renderDebtPage}[p];
  if(fn)await fn();
}

/* ══════════════════════════════════════════════════════════════
   CAMADA DE DADOS — sync único com cache (corrige o problema de
   refazer 4 requisições a cada navegação). force=true refaz.
══════════════════════════════════════════════════════════════ */
async function sync(force=false){
  if(ST.loaded&&!force)return true;
  if(ST.syncing)return ST.syncing;               // reaproveita sync em andamento
  ST.syncing=(async()=>{
    if(!(await ensureSession()))return false;
    // allSettled: se UMA tabela falhar (ex: tabela não criada), as demais
    // ainda carregam — evita que o app inteiro fique vazio por um detalhe.
    const [m,mv,iv,db,ct]=await Promise.allSettled([
      SB.get('salary_months'),SB.get('movements'),SB.get('investments'),SB.get('debts'),
      SB.get('investment_contributions')
    ]);
    const core=[m,mv,iv,db];
    const firstFail=core.find(r=>r.status==='rejected');
    if(firstFail){
      // uma tabela essencial falhou → mostra o erro REAL para diagnóstico
      const e=firstFail.reason;
      const msg=(e&&e.message)||'erro desconhecido';
      toast('Falha ao carregar dados: '+msg,'err');
      ST.syncing=null;return false;
    }
    ST.months=m.value;ST.movs=mv.value;ST.invs=iv.value;ST.debts=db.value;
    ST.contribs=ct.status==='fulfilled'?ct.value:[];   // aportes são opcionais
    ST.loaded=true;ST.syncing=null;return true;
  })();
  return ST.syncing;
}

/* ══════════════════════════════════════════════════════════════
   NAVEGAÇÃO POR MÊS
   • O mês selecionado (ST.sel) é a fonte de verdade das telas
     "por mês": Dashboard, Salário e Movimentos.
   • Investimentos e Dívidas são contínuos (globais) — a barra de
     meses fica oculta neles.
   • Criação preguiçosa: o registro salary_months só é gravado no
     banco quando o usuário digita o primeiro valor (ensureMonth()).
══════════════════════════════════════════════════════════════ */
const MONTH_SCOPED=['dashboard','salary','movements'];   // telas que reagem ao mês

function initSelectedMonth(){
  // 1) tenta o último mês visto (salvo por usuário); 2) senão, mês atual
  const saved=LS.g('lastMonth_'+(uid()||'x'));
  if(saved&&saved.m>=1&&saved.m<=12&&saved.y){ST.sel={m:saved.m,y:saved.y};return}
  const n=new Date();ST.sel={m:n.getMonth()+1,y:n.getFullYear()};
}
function saveSelectedMonth(){
  if(ST.sel)LS.s('lastMonth_'+(uid()||'x'),{m:ST.sel.m,y:ST.sel.y});
}
/* devolve o registro salary_months do mês selecionado (ou null se ainda não existe) */
function currentMonthRow(){
  if(!ST.sel)return null;
  return ST.months.find(s=>s.month===ST.sel.m&&s.year===ST.sel.y)||null;
}
/* movimentos do mês selecionado */
function currentMonthMovs(){
  const row=currentMonthRow();
  return row?ST.movs.filter(v=>v.salary_month_id===row.id):[];
}
/* garante que o mês exista no banco antes de vincular um dado a ele.
   • Race-safe: chamadas concorrentes reaproveitam a mesma promessa.
   • Usa UPSERT (on_conflict user_id,month,year) → nunca duplica nem falha
     por constraint; sempre devolve a linha canônica JÁ PERSISTIDA.
   • Se não conseguir, LANÇA erro (o chamador não grava órfão). */
let _ensuringMonth=null;
async function ensureMonth(){
  const existing=currentMonthRow();
  if(existing)return existing;
  if(_ensuringMonth)return _ensuringMonth;
  _ensuringMonth=(async()=>{
    // recheca depois de "adquirir" a trava
    const again=currentMonthRow();
    if(again)return again;
    const r=await SB.upsert('salary_months',
      {month:ST.sel.m,year:ST.sel.y,gross_amount:0,user_id:uid()},
      'user_id,month,year');
    const row=r&&r[0];
    if(!row||!row.id)throw new Error('Não foi possível criar o mês no banco.');
    if(!ST.months.find(x=>x.id===row.id))ST.months.unshift(row);
    return row;
  })();
  try{return await _ensuringMonth}
  finally{_ensuringMonth=null}
}
function paintMonthLabel(){
  const el=$('mnav-label');if(!el)return;
  el.textContent=MO[ST.sel.m-1]+' '+ST.sel.y;
  const n=new Date();
  el.classList.toggle('current',ST.sel.m===n.getMonth()+1&&ST.sel.y===n.getFullYear());
}
function toggleMonthNav(page){
  $('mnav').classList.toggle('hidden',!MONTH_SCOPED.includes(page));
}
/* troca o mês selecionado e re-renderiza SOMENTE a tela ativa
   (sem recarregar app, sem nova consulta — usa o cache já em memória) */
async function changeMonth(delta){
  let m=ST.sel.m+delta,y=ST.sel.y;
  if(m<1){m=12;y--}else if(m>12){m=1;y++}
  ST.sel={m,y};
  saveSelectedMonth();
  paintMonthLabel();
  ST.mov.page=1;                       // reseta paginação de movimentos
  await animateReload();
}
async function goCurrentMonth(){
  const n=new Date();
  ST.sel={m:n.getMonth()+1,y:n.getFullYear()};
  saveSelectedMonth();paintMonthLabel();ST.mov.page=1;
  await animateReload();
}
/* re-renderiza a página ativa com uma transição suave, reaproveitando cache */
async function animateReload(){
  const pg=$('pg-'+ST.page);
  if(pg){pg.classList.remove('page-switching');void pg.offsetWidth;pg.classList.add('page-switching')}
  await loadPage(ST.page);
}

/* ══════════════════════════════════════════════════════════════
   GRÁFICOS
══════════════════════════════════════════════════════════════ */
let chD=null,chB=null,chInv=null;
function destroyCharts(){if(chD){chD.destroy();chD=null}if(chB){chB.destroy();chB=null}if(chInv){chInv.destroy();chInv=null}}

async function renderDash(){
  if(!(await sync()))return;
  const sm=currentMonthRow();                    // mês selecionado na navegação
  const mm=currentMonthMovs();
  const sum=(t)=>mm.filter(v=>v.type===t).reduce((a,v)=>a+Number(v.amount),0);
  const inc=sum('entrada'),exp=sum('saida'),inv=sum('investimento'),res=sum('reserva');
  const bal=(sm?Number(sm.gross_amount):0)+inc-exp-inv-res;

  animV($('d-sal'),sm?Number(sm.gross_amount):0);
  animV($('d-inc'),inc);animV($('d-exp'),exp);animV($('d-bal'),bal);
  animV($('d-inv'),inv);animV($('d-res'),res);
  $('d-mes').textContent=ml(ST.sel.m,ST.sel.y);
  $('d-dlbl').textContent=MO[ST.sel.m-1].slice(0,3)+' '+ST.sel.y;

  // patrimônio investido
  const pi=ST.invs.reduce((a,i)=>a+Number(i.amount_invested),0);
  const pc=ST.invs.reduce((a,i)=>a+Number(i.current_value),0);
  const pg=pc-pi,pp=pi>0?(pg/pi)*100:0;
  animV($('d-patr'),pc);
  $('d-patr-r').innerHTML='<span style="color:'+(pg>=0?'var(--green)':'var(--red)')+'">'+(pg>=0?'▲':'▼')+' '+esc(Math.abs(pp).toFixed(2))+'%</span>';

  // dívidas
  const drem=ST.debts.reduce((a,d)=>a+Number(d.installment_amount)*(Number(d.installments_total)-Number(d.installments_paid)),0);
  const dpend=ST.debts.reduce((a,d)=>a+(Number(d.installments_total)-Number(d.installments_paid)),0);
  animV($('d-debt'),drem);
  $('d-debt-p').textContent=dpend+' parcela'+(dpend===1?'':'s')+' pendente'+(dpend===1?'':'s');

  // donut
  const catT={};
  mm.filter(v=>v.type!=='entrada').forEach(v=>{const c=v.category||'outros';catT[c]=(catT[c]||0)+Number(v.amount)});
  const cK=Object.keys(catT),cV=cK.map(k=>catT[k]),cC=cK.map(k=>CATS[k]?.c||'#64748b'),cL=cK.map(k=>CATS[k]?.l||k);
  if(chD){chD.destroy();chD=null}
  const legEl=$('ch-leg');
  if(cV.length){
    chD=new Chart($('ch-donut'),{type:'doughnut',
      data:{labels:cL,datasets:[{data:cV,backgroundColor:cC,borderColor:'#080c14',borderWidth:2.5,hoverOffset:10}]},
      options:{maintainAspectRatio:false,cutout:'65%',
        plugins:{legend:{display:false},tooltip:{callbacks:{label:c=>' '+fmt(c.raw)+' ('+Math.round(c.raw/cV.reduce((a,b)=>a+b,0)*100)+'%)'}}},
        animation:{duration:900,easing:'easeInOutQuart'}}});
    legEl.innerHTML=cK.map((k,i)=>
      '<div style="display:flex;align-items:center;justify-content:space-between;gap:8px">'+
      '<div style="display:flex;align-items:center;gap:7px"><div style="width:9px;height:9px;border-radius:3px;background:'+cC[i]+';flex-shrink:0"></div>'+
      '<span style="font-size:12px;color:#94a3b8">'+esc(cL[i])+'</span></div>'+
      '<span style="font-family:var(--m);font-size:12px;font-weight:600">'+fmt(cV[i])+'</span></div>').join('');
  }else{
    legEl.innerHTML='<div class="empty" style="padding:20px"><div class="empty-ico">📊</div><p>Adicione movimentos para ver a distribuição</p></div>';
  }

  // barras 6 meses (terminando no mês selecionado)
  const l6=[];for(let i=5;i>=0;i--){const d=new Date(ST.sel.y,ST.sel.m-1-i,1);l6.push({m:d.getMonth()+1,y:d.getFullYear()})}
  const bL=l6.map(({m})=>MO[m-1].slice(0,3));
  const bS=l6.map(({m,y})=>{const s=ST.months.find(x=>x.month===m&&x.year===y);return s?Number(s.gross_amount):0});
  const bE=l6.map(({m,y})=>{const s=ST.months.find(x=>x.month===m&&x.year===y);if(!s)return 0;
    return ST.movs.filter(v=>v.salary_month_id===s.id&&v.type==='saida').reduce((a,v)=>a+Number(v.amount),0)});
  if(chB){chB.destroy();chB=null}
  chB=new Chart($('ch-bar'),{type:'bar',
    data:{labels:bL,datasets:[
      {label:'Salário',data:bS,backgroundColor:'rgba(34,197,94,.5)',borderColor:'#22c55e',borderWidth:1.5,borderRadius:6,borderSkipped:false},
      {label:'Saídas', data:bE,backgroundColor:'rgba(239,68,68,.35)',borderColor:'#ef4444',borderWidth:1.5,borderRadius:6,borderSkipped:false}]},
    options:{maintainAspectRatio:false,responsive:true,
      plugins:{legend:{labels:{color:'#94a3b8',font:{size:12,family:'Inter'},boxWidth:10,boxHeight:10,borderRadius:3}},
        tooltip:{callbacks:{label:c=>' '+fmt(c.raw)}}},
      scales:{x:{grid:{color:'rgba(255,255,255,.03)'},ticks:{color:'#64748b',font:{size:11}}},
        y:{grid:{color:'rgba(255,255,255,.03)'},ticks:{color:'#64748b',font:{size:11},callback:v=>'R$'+(v>=1000?(v/1000).toFixed(1)+'k':v)}}},
      animation:{duration:900,easing:'easeInOutQuart'}}});

  const recent=mm.slice(0,6);
  $('d-recent').innerHTML=recent.length?recent.map(v=>mviHTML(v)).join('')
    :'<div class="empty"><div class="empty-ico">📭</div><h3>Nenhum movimento em '+esc(MO[ST.sel.m-1]+' '+ST.sel.y)+'</h3><p>Adicione seu salário e comece a registrar.</p></div>';
}

/* ══════════════════════════════════════════════════════════════
   SALÁRIO
══════════════════════════════════════════════════════════════ */
async function renderSalary(){
  if(!(await sync()))return;
  const el=$('salary-list');
  const sm=currentMonthRow();
  const mm=currentMonthMovs();
  const s=t=>mm.filter(v=>v.type===t).reduce((a,v)=>a+Number(v.amount),0);
  const exp=s('saida'),res=s('reserva'),inv=s('investimento'),inc=s('entrada');
  const gross=sm?Number(sm.gross_amount):0;
  const pct=gross>0?Math.min(((exp+res+inv)/gross)*100,100):0;
  const notes=sm?.notes||'';

  el.innerHTML=
    '<div class="card" style="margin-bottom:12px">'+
      '<div style="display:flex;justify-content:space-between;align-items:flex-start;gap:14px;flex-wrap:wrap">'+
        '<div style="flex:1;min-width:200px">'+
          '<div style="font-size:16px;font-weight:700">'+esc(ml(ST.sel.m,ST.sel.y))+'</div>'+
          '<div style="font-size:12px;color:var(--t3);margin-top:2px">'+mm.length+' movimento'+(mm.length===1?'':'s')+'</div>'+
          '<div style="margin-top:14px">'+
            '<label class="lbl">Salário bruto (salva automaticamente)</label>'+
            '<input class="inp" id="sal-gross" type="number" step="0.01" min="0" value="'+(gross||'')+'" placeholder="0,00" style="max-width:220px;font-size:16px;font-weight:700"/>'+
            '<span id="sal-status" style="font-size:11.5px;color:var(--t3);margin-left:10px"></span>'+
          '</div>'+
          '<div style="margin-top:12px">'+
            '<label class="lbl">Observação do mês (opcional)</label>'+
            '<input class="inp" id="sal-notes" type="text" maxlength="160" value="'+esc(notes)+'" placeholder="Ex: salário + bônus" style="max-width:360px"/>'+
          '</div>'+
        '</div>'+
        '<div style="text-align:right">'+
          '<div style="font-family:var(--m);font-size:22px;font-weight:700;color:var(--green)">'+fmt(gross)+'</div>'+
          '<div style="font-size:12px;color:var(--red);margin-top:2px">Saídas: '+fmt(exp)+'</div>'+
          '<div style="font-size:12px;color:var(--indigo);margin-top:2px">Entradas: '+fmt(inc)+'</div>'+
        '</div>'+
      '</div>'+
      '<div class="prog" style="margin-top:16px"><div class="pf pfa" style="width:'+pct+'%"></div></div>'+
      '<div style="display:flex;justify-content:space-between;font-size:11.5px;color:var(--t3)">'+
        '<span>'+pct.toFixed(0)+'% distribuído</span><span>Inv: '+fmt(inv)+' · Res: '+fmt(res)+'</span></div>'+
      (mm.length?'<div class="dv"></div><div style="font-size:11px;font-weight:700;color:var(--t2);margin-bottom:8px;text-transform:uppercase;letter-spacing:.06em">Movimentos do mês</div>'+
        mm.slice(0,6).map(v=>mviHTML(v,true)).join('')+
        (mm.length>6?'<div style="text-align:center;margin-top:8px"><button class="btn btn-o btn-sm" data-nav="movements" type="button">Ver todos ('+mm.length+') →</button></div>':'')
        :'<div class="dv"></div><div class="empty" style="padding:24px"><div class="empty-ico">📭</div><p>Nenhum movimento neste mês ainda.</p></div>')+
      '<div style="display:flex;gap:8px;justify-content:flex-end;margin-top:14px">'+
        '<button class="btn btn-g btn-sm" data-act="openAddMov" type="button">+ Movimento</button>'+
        (sm?'<button class="btn btn-r btn-sm" data-act="delSalary" data-arg="'+esc(sm.id)+'" type="button">Excluir mês</button>':'')+
      '</div>'+
    '</div>';

  // auto-save do salário (cria o mês preguiçosamente se ainda não existe)
  wireAutoSaveSalary();
}

/* liga o salvamento automático dos campos de salário e observação */
function wireAutoSaveSalary(){
  const gEl=$('sal-gross'),nEl=$('sal-notes'),st=$('sal-status');
  if(!gEl)return;
  let t=null;
  const flush=async(patch)=>{
    if(st){st.textContent='salvando...';st.style.color='var(--t3)'}
    try{
      const row=await ensureMonth();          // lança se não conseguir criar o mês
      const r=await SB.upd('salary_months',row.id,patch);
      if(!r||!r[0])throw new Error('não confirmado pelo servidor');
      const i=ST.months.findIndex(x=>x.id===row.id);if(i>=0)ST.months[i]=r[0];
      if(st){st.textContent='✓ salvo';st.style.color='var(--green)';setTimeout(()=>{if(st)st.textContent=''},1500)}
    }catch(err){
      if(st){st.textContent='✗ '+((err&&err.message)||'erro ao salvar');st.style.color='var(--red)'}
      toast('Salário não salvo: '+((err&&err.message)||'erro'),'err');
    }
  };
  const debounced=(patch)=>{clearTimeout(t);t=setTimeout(()=>flush(patch),600)};
  gEl.addEventListener('input',()=>{const v=parseFloat(gEl.value)||0;debounced({gross_amount:v})});
  gEl.addEventListener('blur',()=>{clearTimeout(t);const v=parseFloat(gEl.value)||0;flush({gross_amount:v})});
  nEl.addEventListener('input',()=>debounced({notes:nEl.value.trim()}));
}

/* ══════════════════════════════════════════════════════════════
   MOVIMENTOS — busca, filtro, ordenação, paginação
══════════════════════════════════════════════════════════════ */
async function renderMovPage(){
  if(!(await sync()))return;
  const mf=$('mf-m');
  const selRow=currentMonthRow();
  // o filtro de mês acompanha o mês selecionado na navegação; "Todos" continua disponível
  mf.innerHTML='<option value="__sel__">'+esc(ml(ST.sel.m,ST.sel.y))+' (selecionado)</option>'+
    '<option value="">Todos os meses</option>'+
    ST.months.filter(s=>!(s.month===ST.sel.m&&s.year===ST.sel.y))
      .map(s=>'<option value="'+esc(s.id)+'">'+esc(ml(s.month,s.year))+'</option>').join('');
  mf.value='__sel__';
  $('mf-c').innerHTML='<option value="">Todas categorias</option>'+Object.entries(CATS).map(([k,v])=>'<option value="'+k+'">'+v.e+' '+v.l+'</option>').join('');
  ST.mov.page=1;
  filterMov();
}
function getFilteredMovs(){
  const q=$('mf-q').value.trim().toLowerCase();
  let mid=$('mf-m').value;
  const typ=$('mf-t').value,cat=$('mf-c').value,sort=$('mf-sort').value;
  let list=ST.movs.slice();
  if(mid==='__sel__'){                      // mês selecionado na navegação
    const row=currentMonthRow();
    list=row?list.filter(v=>v.salary_month_id===row.id):[];
  }else if(mid){
    list=list.filter(v=>v.salary_month_id===mid);
  } // '' = todos os meses
  if(typ)list=list.filter(v=>v.type===typ);
  if(cat)list=list.filter(v=>v.category===cat);
  if(q)list=list.filter(v=>(v.description||'').toLowerCase().includes(q));
  const [key,dir]=sort.split('-');
  list.sort((a,b)=>{
    let r=0;
    if(key==='amount')r=Number(a.amount)-Number(b.amount);
    else r=new Date(a.date||a.created_at)-new Date(b.date||b.created_at);
    return dir==='asc'?r:-r;
  });
  return list;
}
function filterMov(){
  const list=getFilteredMovs();
  const totalPages=Math.max(1,Math.ceil(list.length/PAGE_SIZE));
  if(ST.mov.page>totalPages)ST.mov.page=totalPages;
  const start=(ST.mov.page-1)*PAGE_SIZE;
  const pageItems=list.slice(start,start+PAGE_SIZE);
  const tot=list.reduce((a,v)=>a+(v.type==='entrada'?Number(v.amount):-Number(v.amount)),0);

  $('mov-list').innerHTML=pageItems.length?pageItems.map(v=>mviHTML(v,true)).join('')
    :'<div class="empty"><div class="empty-ico">🔍</div><h3>Nenhum resultado</h3><p>Tente outros filtros ou busca.</p></div>';

  // paginação
  const pg=$('mov-pager');
  if(totalPages>1){
    pg.innerHTML='<button class="btn btn-o btn-sm" data-page="prev" '+(ST.mov.page<=1?'disabled':'')+' type="button">← Anterior</button>'+
      '<span style="font-size:12.5px;color:var(--t2);align-self:center">Página '+ST.mov.page+' de '+totalPages+'</span>'+
      '<button class="btn btn-o btn-sm" data-page="next" '+(ST.mov.page>=totalPages?'disabled':'')+' type="button">Próxima →</button>';
  }else pg.innerHTML='';

  // ── Restante disponível do MÊS SELECIONADO (tempo real) ──
  // Regra: Salário + Entradas − Saídas − Reservas − Investimentos
  const selRow=currentMonthRow();
  const monthMovs=currentMonthMovs();
  const sumT=t=>monthMovs.filter(v=>v.type===t).reduce((a,v)=>a+Number(v.amount),0);
  const salario=selRow?Number(selRow.gross_amount):0;
  const restante=salario+sumT('entrada')-sumT('saida')-sumT('reserva')-sumT('investimento');
  const restColor=restante>=0?'var(--green)':'var(--red)';
  const restLine='<span style="font-size:12px">Restante disponível ('+esc(MO[ST.sel.m-1]+' '+ST.sel.y)+'): <strong style="color:'+restColor+';font-family:var(--m)">'+esc(fmt(restante))+'</strong></span>';

  $('mov-tot').innerHTML=list.length
    ?'Saldo do filtro: <strong style="color:'+(tot>=0?'var(--green)':'var(--red)')+';font-family:var(--m)">'+(tot>=0?'+':'')+esc(fmt(tot))+'</strong> · '+list.length+' registros<br>'+restLine
    :restLine;
}
function mviHTML(v,actions){
  const cat=CATS[v.category]||CATS.outros,sign=v.type==='entrada'?'+':'−';
  const sm=ST.months.find(s=>s.id===v.salary_month_id);
  return '<div class="mvi">'+
    '<div class="mvi-em">'+cat.e+'</div>'+
    '<div class="mvi-inf">'+
      '<div class="mvi-d">'+esc(v.description)+'</div>'+
      '<div class="mvi-m">'+esc(cat.l)+(sm?' · '+esc(ml(sm.month,sm.year)):'')+' · <span class="badge '+(TCLS[v.type]||'bg')+'">'+esc(TMAP[v.type]||v.type)+'</span></div>'+
    '</div>'+
    '<div class="mvi-v '+esc(v.type)+'">'+sign+' '+fmt(v.amount)+'</div>'+
    (actions?'<div class="mvi-acts">'+
      '<button class="btn btn-o btn-ic btn-sm" data-act="dupMov" data-arg="'+esc(v.id)+'" title="Duplicar" type="button">⧉</button>'+
      '<button class="btn btn-o btn-ic btn-sm" data-act="openEditMov" data-arg="'+esc(v.id)+'" title="Editar" type="button">✎</button>'+
      '<button class="btn btn-r btn-ic btn-sm" data-act="delMov" data-arg="'+esc(v.id)+'" title="Excluir" type="button">🗑</button>'+
    '</div>':'')+
  '</div>';
}

/* ══════════════════════════════════════════════════════════════
   INVESTIMENTOS
══════════════════════════════════════════════════════════════ */
/* ══════════════════════════════════════════════════════════════
   PLANEJADOR TESOURO IPCA+ 2032
   • Campos editáveis (valor inicial, aporte mensal, taxas, datas).
   • Salvamento automático no navegador por usuário (não toca no banco).
   • Cálculo completo: IPCA + taxa real, custo B3, IR regressivo,
     e projeções ano a ano com gráfico.
══════════════════════════════════════════════════════════════ */
const DAY_MS=86400000;
function parseDate(s){if(!s)return null;const d=new Date(String(s).length<=10?s+'T00:00:00':s);return isNaN(d)?null:d;}
const IPCA_DEFAULTS={
  nome:'Tesouro IPCA+ 2032',
  inicial:1000,          // valor inicial (R$)
  mensal:300,            // aporte mensal (R$)
  real:8.28,             // taxa real (% a.a.) acima da inflação
  ipca:4.50,             // IPCA estimado (% a.a.) — editável
  b3:0.20,               // taxa de custódia da B3 (% a.a.)
  preco:2927.89,         // preço unitário do título (R$)
  inicio:null,           // data de início (default: hoje)
  vencimento:'2032-08-15'
};
function ipcaCfg(){
  const saved=LS.g('ipcaPlan_'+(uid()||'x'))||{};
  const cfg=Object.assign({},IPCA_DEFAULTS,saved);
  if(!cfg.inicio)cfg.inicio=new Date().toISOString().split('T')[0];
  return cfg;
}
/* Converte texto digitado (com vírgula OU ponto) em número.
   Aceita "2.927,89", "2927,89", "2927.89", "2.927" (milhar) e "2,927". */
function brNum(raw){
  if(raw==null)return 0;
  let s=String(raw).trim().replace(/\s/g,'').replace(/R\$/gi,'').replace(/%/g,'');
  if(!s)return 0;
  const hasComma=s.includes(','), hasDot=s.includes('.');
  if(hasComma&&hasDot){
    // formato brasileiro: ponto = milhar, vírgula = decimal
    s=s.replace(/\./g,'').replace(',', '.');
  }else if(hasComma){
    s=s.replace(',', '.');                     // só vírgula → decimal
  }else if(hasDot){
    // só ponto: se for padrão de milhar (ex.: 2.927 ou 1.234.567), remove os pontos;
    // senão (ex.: 12.5), mantém como decimal internacional.
    if(/^\d{1,3}(\.\d{3})+$/.test(s))s=s.replace(/\./g,'');
  }
  const n=parseFloat(s);
  return isNaN(n)?0:n;
}
function ipcaSave(patch){
  const cur=ipcaCfg();
  LS.s('ipcaPlan_'+(uid()||'x'),Object.assign({},cur,patch));
}
/* taxa nominal líquida anual (decimal): compõe real sobre IPCA e desconta B3 */
function ipcaAnnualNet(cfg){
  const nominal=(1+cfg.real/100)*(1+cfg.ipca/100)-1;
  return nominal-(cfg.b3||0)/100;
}
/* alíquota de IR regressivo conforme dias aplicados */
function irRate(days){
  if(days<=180)return 0.225;
  if(days<=360)return 0.20;
  if(days<=720)return 0.175;
  return 0.15;
}
/* monta a lista de aportes (inicial + mensais) do início ao vencimento */
function ipcaContribs(cfg){
  const start=parseDate(cfg.inicio)||new Date();
  const end=parseDate(cfg.vencimento)||start;
  const list=[{date:new Date(start),amount:Number(cfg.inicial)||0,kind:'inicial'}];
  const d=new Date(start);d.setMonth(d.getMonth()+1);
  let guard=0;
  while(d<=end&&guard<600){list.push({date:new Date(d),amount:Number(cfg.mensal)||0,kind:'mensal'});d.setMonth(d.getMonth()+1);guard++}
  return list;
}
/* projeta o investimento numa data futura: aportado, bruto, IR, líquido */
function ipcaProjectAt(cfg,atDate){
  const annualNet=ipcaAnnualNet(cfg);
  let gross=0,invested=0,ir=0;
  for(const c of ipcaContribs(cfg)){
    if(c.date>atDate)continue;
    const days=(atDate-c.date)/DAY_MS;
    const grown=c.amount*Math.pow(1+annualNet,days/365);
    const gain=grown-c.amount;
    gross+=grown;invested+=c.amount;
    if(gain>0)ir+=gain*irRate(days);
  }
  return {invested,gross,gain:gross-invested,ir,net:gross-ir,netGain:gross-ir-invested};
}

async function renderInvPage(){
  if(!(await sync()))return;
  const cfg=ipcaCfg();
  const el=$('inv-list');
  const venc=parseDate(cfg.vencimento),now=new Date();
  const diasAteVenc=venc?Math.max(Math.ceil((venc-now)/DAY_MS),0):0;
  const anosAteVenc=(diasAteVenc/365);

  const field=(id,label,val,suffix,icon)=>
    '<div class="ip-field"><label class="lbl" for="'+id+'">'+(icon?icon+' ':'')+label+'</label>'+
    '<div class="ip-inputwrap">'+
    '<input class="inp ipca-fld" id="'+id+'" type="text" inputmode="decimal" autocomplete="off" value="'+esc(val)+'"'+
    (suffix?' style="padding-right:44px"':'')+'/>'+
    (suffix?'<span class="ip-suffix">'+suffix+'</span>':'')+
    '</div></div>';
  const dfield=(id,label,val,icon)=>
    '<div class="ip-field"><label class="lbl" for="'+id+'">'+(icon?icon+' ':'')+label+'</label>'+
    '<input class="inp ipca-fld" id="'+id+'" type="date" value="'+esc(val)+'"/></div>';

  // ── ESTRUTURA MONTADA UMA ÚNICA VEZ ──
  // Os inputs ficam em #ipca-inputs (nunca recriados na digitação).
  // Só #ipca-results é atualizado a cada tecla → o foco nunca se perde.
  el.innerHTML=
    // cabeçalho
    '<div class="ip-hero">'+
      '<div class="ip-hero-glow"></div>'+
      '<div style="position:relative;z-index:1;display:flex;justify-content:space-between;align-items:flex-start;flex-wrap:wrap;gap:12px">'+
        '<div><div class="ip-hero-title">🏛️ '+esc(cfg.nome)+'</div>'+
          '<div class="ip-hero-sub" id="ip-hero-sub">IPCA + '+esc(cfg.real.toFixed(2))+'% a.a. · vence em '+(venc?venc.toLocaleDateString('pt-BR'):'—')+'</div></div>'+
        '<div style="text-align:right"><span class="ip-countdown" id="ip-countdown">faltam '+diasAteVenc+' dias</span>'+
          '<div style="font-size:11px;color:var(--t3);margin-top:6px" id="ip-years">≈ '+anosAteVenc.toFixed(1)+' anos até o vencimento</div></div>'+
      '</div>'+
    '</div>'+

    // parâmetros editáveis — montados UMA vez
    '<div class="sec"><h2>Meu plano</h2><span class="badge bs">💾 salva automaticamente</span></div>'+
    '<div class="card ip-plan" style="margin-bottom:16px">'+
      '<div id="ipca-inputs" class="ip-grid">'+
        field('ip-inicial','Valor inicial',cfg.inicial,'R$','💰')+
        field('ip-mensal','Aporte mensal',cfg.mensal,'R$','📅')+
        field('ip-real','Taxa real (IPCA+)',cfg.real,'%','📈')+
        field('ip-ipca','IPCA estimado',cfg.ipca,'%','🔥')+
        field('ip-b3','Taxa B3',cfg.b3,'%','🏦')+
        field('ip-preco','Preço unitário',cfg.preco,'R$','🎫')+
        dfield('ip-inicio','Data de início',cfg.inicio,'▶️')+
        dfield('ip-venc','Vencimento',cfg.vencimento,'🏁')+
      '</div>'+
      '<div class="ip-ratehint" id="ip-ratehint"></div>'+
    '</div>'+

    // zona de resultados — ÚNICA parte recalculada a cada tecla
    '<div id="ipca-results"></div>';

  wireIpcaFields();      // liga listeners UMA vez (nos inputs que não serão recriados)
  updateIpcaResults();   // preenche resultados + gráfico
}

/* Atualiza SOMENTE a zona de resultados (não toca nos inputs → foco preservado) */
function updateIpcaResults(){
  const cfg=ipcaCfg();
  const box=$('ipca-results');if(!box)return;
  const start=parseDate(cfg.inicio),venc=parseDate(cfg.vencimento),now=new Date();
  const annualNet=ipcaAnnualNet(cfg);
  const nominal=(1+cfg.real/100)*(1+cfg.ipca/100)-1;
  const contribs=ipcaContribs(cfg);
  const nAportes=contribs.length;
  const totalAportado=contribs.reduce((a,c)=>a+c.amount,0);
  const fin=ipcaProjectAt(cfg,venc);
  const hoje=ipcaProjectAt(cfg,now);
  const diasAteVenc=venc?Math.max(Math.ceil((venc-now)/DAY_MS),0):0;
  const qtdTitulos=cfg.preco>0?(cfg.inicial/cfg.preco):0;
  const rentLiquidaPct=totalAportado>0?(fin.netGain/totalAportado)*100:0;
  const money=v=>'<span style="font-family:var(--m)">'+fmt(v)+'</span>';

  // atualiza cabeçalho e dica de taxa (sem recriar inputs)
  const subEl=$('ip-hero-sub');if(subEl)subEl.textContent='IPCA + '+cfg.real.toFixed(2)+'% a.a. · vence em '+(venc?venc.toLocaleDateString('pt-BR'):'—');
  const cdEl=$('ip-countdown');if(cdEl)cdEl.textContent='faltam '+diasAteVenc+' dias';
  const yrEl=$('ip-years');if(yrEl)yrEl.textContent='≈ '+(diasAteVenc/365).toFixed(1)+' anos até o vencimento';
  const hint=$('ip-ratehint');
  if(hint)hint.innerHTML='💡 Taxa nominal estimada: <strong style="color:var(--amber)">'+(nominal*100).toFixed(2)+'% a.a.</strong> '+
    '(IPCA '+cfg.ipca.toFixed(2)+'% + real '+cfg.real.toFixed(2)+'%). Descontando a B3: <strong style="color:var(--indigo)">'+(annualNet*100).toFixed(2)+'% a.a.</strong> líquida. '+
    'Como o IPCA futuro é incerto, ajuste "IPCA estimado" para simular cenários.';

  const bigbox=(label,value,cls,sub)=>
    '<div class="ip-stat '+(cls||'')+'">'+
      '<div class="ip-stat-lbl">'+label+'</div>'+
      '<div class="ip-stat-val">'+value+'</div>'+
      (sub?'<div class="ip-stat-sub">'+sub+'</div>':'')+'</div>';

  box.innerHTML=
    '<div class="sec"><h2>Projeção no vencimento'+(venc?' ('+venc.toLocaleDateString('pt-BR')+')':'')+'</h2></div>'+
    '<div class="ip-stats" style="margin-bottom:16px">'+
      bigbox('Total aportado',money(totalAportado),'s-neutral',nAportes+' aportes')+
      bigbox('Valor bruto',money(fin.gross),'s-indigo','antes de impostos')+
      bigbox('IR previsto',money(fin.ir),'s-amber','tabela regressiva')+
      bigbox('Valor líquido',money(fin.net),'s-green','já com IR')+
      bigbox('Rendimento líquido',money(fin.netGain),fin.netGain>=0?'s-green':'s-red','lucro após IR')+
      bigbox('Rentabilidade',rentLiquidaPct.toFixed(1)+'%','s-green','sobre o aportado')+
    '</div>'+

    '<div class="card ip-today" style="margin-bottom:16px">'+
      '<div style="display:flex;justify-content:space-between;flex-wrap:wrap;gap:14px">'+
        '<div><div class="card-lbl">Valor estimado hoje</div>'+
          '<div class="ip-today-val">'+fmt(hoje.gross)+'</div>'+
          '<div class="card-sub">aportado: '+fmt(hoje.invested)+' · juros: '+fmt(hoje.gain)+'</div></div>'+
        '<div style="text-align:right"><div class="card-lbl">Títulos no aporte inicial</div>'+
          '<div class="ip-today-val" style="-webkit-text-fill-color:var(--t1)">'+qtdTitulos.toFixed(4)+'</div>'+
          '<div class="card-sub">a '+fmt(cfg.preco)+' cada</div></div>'+
      '</div>'+
    '</div>'+

    '<div class="card" style="margin-bottom:16px">'+
      '<div class="sec" style="margin-top:0;margin-bottom:14px"><h2>Evolução projetada</h2><span class="badge bg">Aportado × Líquido</span></div>'+
      '<div class="chw" style="height:250px"><canvas id="ch-ipca"></canvas></div>'+
    '</div>'+

    '<div class="sec"><h2>Previsão ano a ano</h2></div>'+
    '<div class="card ip-tablecard" style="margin-bottom:16px;overflow-x:auto">'+ipcaYearTable(cfg,start,venc)+'</div>'+

    '<div class="sec"><h2>E se eu aumentar o aporte mensal?</h2></div>'+
    '<div class="card ip-tablecard" style="margin-bottom:16px;overflow-x:auto">'+ipcaSimTable(cfg,venc)+'</div>'+

    '<details class="card" style="margin-bottom:16px"><summary style="cursor:pointer;font-size:13px;font-weight:700">📋 Características do título</summary>'+
      '<div style="margin-top:12px;display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:10px;font-size:12.5px;color:var(--t2)">'+
        '<div>Pagamento de juros: <strong style="color:var(--t1)">no vencimento</strong></div>'+
        '<div>IR sobre o rendimento: <strong style="color:var(--t1)">22,5% → 15%</strong></div>'+
        '<div>IOF: <strong style="color:var(--t1)">isento após 30 dias</strong></div>'+
        '<div>Taxa da B3: <strong style="color:var(--t1)">'+cfg.b3.toFixed(2)+'% a.a.</strong></div>'+
        '<div>Liquidação: <strong style="color:var(--t1)">1 dia útil</strong></div>'+
        '<div>Valor mínimo: <strong style="color:var(--t1)">'+fmt(cfg.preco*0.01)+'</strong></div>'+
      '</div></details>';

  drawIpcaChart(cfg,start,venc);
}

/* liga o salvamento automático UMA vez; a digitação NÃO recria os inputs.
   Só a zona de resultados é recalculada (debounce curto) → foco preservado. */
function wireIpcaFields(){
  const map={'ip-inicial':'inicial','ip-mensal':'mensal','ip-real':'real','ip-ipca':'ipca','ip-b3':'b3','ip-preco':'preco','ip-inicio':'inicio','ip-venc':'vencimento'};
  let t=null;
  Object.keys(map).forEach(id=>{
    const eln=$(id);if(!eln)return;
    const handler=()=>{
      const key=map[id];
      const raw=eln.value;
      const value=(id==='ip-inicio'||id==='ip-venc')?raw:brNum(raw);
      ipcaSave({[key]:value});
      clearTimeout(t);t=setTimeout(updateIpcaResults,300);   // atualiza SÓ resultados
    };
    eln.addEventListener('input',handler);
    eln.addEventListener('change',handler);   // datas e blur
  });
}
function ipcaYearTable(cfg,start,venc){
  if(!start||!venc)return '';
  const rows=[];
  const endY=venc.getFullYear();
  for(let y=start.getFullYear();y<=endY;y++){
    const at=(y===endY)?new Date(venc):new Date(y,11,31);
    if(at<start)continue;
    const p=ipcaProjectAt(cfg,at>venc?venc:at);
    rows.push({ano:y,at:(at>venc?venc:at),...p});
  }
  const head='<tr>'+['Ano','Aportado','Bruto','IR','Líquido','Lucro líq.'].map(h=>
    '<th style="text-align:'+(h==='Ano'?'left':'right')+';padding:7px 9px;color:var(--t3);font-weight:600;font-size:11px;text-transform:uppercase;letter-spacing:.04em">'+h+'</th>').join('')+'</tr>';
  const body=rows.map(r=>'<tr style="border-top:1px solid var(--b)">'+
    '<td style="padding:7px 9px;font-weight:700">'+r.ano+(r.at.getTime()===venc.getTime()?' <span class="badge bg" style="font-size:9px">venc.</span>':'')+'</td>'+
    '<td style="text-align:right;padding:7px 9px;font-family:var(--m)">'+fmt(r.invested)+'</td>'+
    '<td style="text-align:right;padding:7px 9px;font-family:var(--m);color:var(--indigo)">'+fmt(r.gross)+'</td>'+
    '<td style="text-align:right;padding:7px 9px;font-family:var(--m);color:var(--amber)">'+fmt(r.ir)+'</td>'+
    '<td style="text-align:right;padding:7px 9px;font-family:var(--m);color:var(--green);font-weight:700">'+fmt(r.net)+'</td>'+
    '<td style="text-align:right;padding:7px 9px;font-family:var(--m);color:'+(r.netGain>=0?'var(--green)':'var(--red)')+'">'+fmt(r.netGain)+'</td>'+
    '</tr>').join('');
  return '<table style="width:100%;border-collapse:collapse;font-size:12px"><thead>'+head+'</thead><tbody>'+body+'</tbody></table>';
}

/* simulação: aporte mensal atual e +100/+300/+500 até o vencimento */
function ipcaSimTable(cfg,venc){
  if(!venc)return '';
  const extras=[0,100,300,500];
  const head='<tr>'+['Aporte mensal','Total aportado','Valor líquido','Lucro líquido'].map((h,i)=>
    '<th style="text-align:'+(i===0?'left':'right')+';padding:7px 9px;color:var(--t3);font-weight:600;font-size:11px;text-transform:uppercase;letter-spacing:.04em">'+h+'</th>').join('')+'</tr>';
  const body=extras.map(ex=>{
    const c=Object.assign({},cfg,{mensal:Number(cfg.mensal)+ex});
    const contribs=ipcaContribs(c);
    const aportado=contribs.reduce((a,x)=>a+x.amount,0);
    const p=ipcaProjectAt(c,venc);
    const atual=ex===0;
    return '<tr style="border-top:1px solid var(--b)'+(atual?';background:rgba(34,197,94,.05)':'')+'">'+
      '<td style="padding:7px 9px;font-family:var(--m);font-weight:700;color:'+(atual?'var(--green)':'var(--t1)')+'">'+fmt(c.mensal)+(atual?' <span class="badge bg" style="font-size:9px">atual</span>':'')+'</td>'+
      '<td style="text-align:right;padding:7px 9px;font-family:var(--m)">'+fmt(aportado)+'</td>'+
      '<td style="text-align:right;padding:7px 9px;font-family:var(--m);color:var(--indigo);font-weight:700">'+fmt(p.net)+'</td>'+
      '<td style="text-align:right;padding:7px 9px;font-family:var(--m);color:var(--green)">'+fmt(p.netGain)+'</td>'+
      '</tr>';
  }).join('');
  return '<table style="width:100%;border-collapse:collapse;font-size:12px"><thead>'+head+'</thead><tbody>'+body+'</tbody></table>';
}

/* gráfico de linha: total aportado × valor líquido projetado, ano a ano */
function drawIpcaChart(cfg,start,venc){
  const cv=$('ch-ipca');if(!cv||!start||!venc)return;
  if(chInv){chInv.destroy();chInv=null}
  const labels=[],aport=[],liq=[];
  const endY=venc.getFullYear();
  for(let y=start.getFullYear();y<=endY;y++){
    const at=(y===endY)?new Date(venc):new Date(y,11,31);
    if(at<start)continue;
    const p=ipcaProjectAt(cfg,at>venc?venc:at);
    labels.push(String(y));aport.push(p.invested);liq.push(p.net);
  }
  chInv=new Chart(cv,{type:'line',
    data:{labels,datasets:[
      {label:'Total aportado',data:aport,borderColor:'#64748b',backgroundColor:'rgba(100,116,139,.1)',borderWidth:2,tension:.3,fill:true,pointRadius:2},
      {label:'Valor líquido projetado',data:liq,borderColor:'#22c55e',backgroundColor:'rgba(34,197,94,.12)',borderWidth:2.5,tension:.3,fill:true,pointRadius:2}
    ]},
    options:{maintainAspectRatio:false,responsive:true,
      plugins:{legend:{labels:{color:'#94a3b8',font:{size:12,family:'Inter'},boxWidth:10,boxHeight:10,borderRadius:3}},
        tooltip:{callbacks:{label:c=>' '+c.dataset.label+': '+fmt(c.raw)}}},
      scales:{x:{grid:{color:'rgba(255,255,255,.03)'},ticks:{color:'#64748b',font:{size:11}}},
        y:{grid:{color:'rgba(255,255,255,.03)'},ticks:{color:'#64748b',font:{size:11},callback:v=>'R$'+(v>=1000?(v/1000).toFixed(0)+'k':v)}}},
      animation:{duration:800,easing:'easeInOutQuart'}}});
}

/* ══════════════════════════════════════════════════════════════
   DÍVIDAS
══════════════════════════════════════════════════════════════ */
function nextDueLabel(d){
  const day=d.due_day;if(!day)return null;
  const now=new Date();let due=new Date(now.getFullYear(),now.getMonth(),day);
  if(due<new Date(now.getFullYear(),now.getMonth(),now.getDate()))due=new Date(now.getFullYear(),now.getMonth()+1,day);
  return due;
}
async function renderDebtPage(){
  if(!(await sync()))return;
  const open=ST.debts.filter(d=>Number(d.installments_paid)<Number(d.installments_total));
  const rem=ST.debts.reduce((a,d)=>a+Number(d.installment_amount)*(Number(d.installments_total)-Number(d.installments_paid)),0);
  const pend=ST.debts.reduce((a,d)=>a+(Number(d.installments_total)-Number(d.installments_paid)),0);
  animV($('db-tot'),rem);
  $('db-pend').textContent=pend+' parcela'+(pend===1?'':'s');
  // próximo vencimento
  let next=null,nextDebt=null;
  open.forEach(d=>{const due=nextDueLabel(d);if(due&&(!next||due<next)){next=due;nextDebt=d}});
  if(next){$('db-next').textContent=next.toLocaleDateString('pt-BR');$('db-next-d').textContent=nextDebt.description}
  else{$('db-next').textContent='—';$('db-next-d').textContent='Sem vencimentos'}

  const el=$('dbt-list');
  if(!ST.debts.length){el.innerHTML='<div class="empty"><div class="empty-ico">🎉</div><h3>Nenhuma dívida!</h3><p>Você está limpo. Ótimo trabalho!</p></div>';return}
  el.innerHTML=ST.debts.map(d=>{
    const paid=Number(d.installments_paid),tot=Number(d.installments_total),r=tot-paid,pct=tot>0?(paid/tot)*100:0;
    const quit=r<=0;
    return '<div class="card" style="margin-bottom:12px">'+
      '<div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:12px">'+
        '<div><div style="font-size:15px;font-weight:700">💳 '+esc(d.description)+' '+(quit?'<span class="badge bg">Quitado</span>':'<span class="badge ba">Em aberto</span>')+'</div>'+
          '<div style="font-size:12px;color:var(--t2);margin-top:2px">'+(d.due_day?'Vence dia '+esc(d.due_day)+' · ':'')+paid+'/'+tot+' pagas</div></div>'+
        '<div style="text-align:right">'+
          '<div style="font-family:var(--m);font-size:19px;font-weight:700;color:var(--red)">'+fmt(d.installment_amount)+'/mês</div>'+
          '<div style="font-size:12px;color:var(--t3);margin-top:2px">Total: '+fmt(d.total_amount)+'</div></div></div>'+
      '<div class="prog"><div class="pf '+(quit?'pfg':'pfa')+'" style="width:'+pct+'%"></div></div>'+
      '<div style="display:flex;justify-content:space-between;font-size:11.5px;color:var(--t3)">'+
        '<span>'+pct.toFixed(0)+'% quitado</span><span>'+r+' restantes · '+fmt(r*Number(d.installment_amount))+' a pagar</span></div>'+
      (r>0?'<div style="margin-top:14px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:8px">'+
        '<span style="font-size:13px;color:var(--t2)">Próxima: <strong style="color:var(--t1)">'+(paid+1)+'ª parcela — '+fmt(d.installment_amount)+'</strong></span>'+
        '<button class="btn btn-g btn-sm" data-act="payInst" data-arg="'+esc(d.id)+'" type="button">✓ Registrar pagamento</button></div>'
        :'<div style="margin-top:12px"><span class="badge bg">✅ Dívida quitada!</span></div>')+
      '<div class="card-actions"><button class="btn btn-r btn-sm" data-act="delDebt" data-arg="'+esc(d.id)+'" type="button">Excluir dívida</button></div></div>';
  }).join('');
}

/* ══════════════════════════════════════════════════════════════
   VALIDAÇÃO DE FORMULÁRIO (reutilizável)
══════════════════════════════════════════════════════════════ */
function num(id){const v=parseFloat($(id)?.value);return isNaN(v)?0:v}
function intv(id){const v=parseInt($(id)?.value,10);return isNaN(v)?0:v}
function val(id){return ($(id)?.value||'').trim()}
function fieldErr(id,msg){
  const inp=$(id);if(!inp)return;
  inp.classList.toggle('invalid',!!msg);
  let e=inp.parentElement.querySelector('.ferr');
  if(!e){e=document.createElement('div');e.className='ferr';inp.parentElement.appendChild(e)}
  e.textContent=msg||'';e.classList.toggle('show',!!msg);
}

/* ══════════════════════════════════════════════════════════════
   MODAIS — SALÁRIO
══════════════════════════════════════════════════════════════ */
function openAddSalary(){
  const n=new Date();
  openModal('Novo mês de salário',
    '<div class="fr">'+
      '<div class="fg"><label class="lbl">Mês</label><select class="inp" id="fm-m">'+
        MO.map((m,i)=>'<option value="'+(i+1)+'"'+(i===n.getMonth()?' selected':'')+'>'+m+'</option>').join('')+'</select></div>'+
      '<div class="fg"><label class="lbl">Ano</label><input class="inp" type="number" id="fm-y" value="'+n.getFullYear()+'" min="2000" max="2100"/></div></div>'+
    '<div class="fg"><label class="lbl">Salário bruto (R$)</label><input class="inp" type="number" id="fm-a" step="0.01" min="0" placeholder="0,00"/></div>'+
    '<div class="fg"><label class="lbl">Observação (opcional)</label><input class="inp" type="text" id="fm-n" maxlength="120" placeholder="Ex: salário + bônus"/></div>'+
    '<div style="display:flex;gap:8px;justify-content:flex-end;margin-top:8px">'+
      '<button class="btn btn-o" data-act="closeModal" type="button">Cancelar</button>'+
      '<button class="btn btn-g" data-act="saveSalary" id="save-sal" type="button">Salvar mês</button></div>');
}
async function saveSalary(){
  const month=intv('fm-m'),year=intv('fm-y'),amount=num('fm-a'),notes=val('fm-n');
  fieldErr('fm-a','');
  if(amount<=0){fieldErr('fm-a','Informe um valor maior que zero.');return}
  setBtn('save-sal',true);
  try{
    const r=await SB.ins('salary_months',{month,year,gross_amount:amount,notes,user_id:uid()});
    if(r?.[0])ST.months.unshift(r[0]);
    toast('Mês adicionado!');closeModal();renderSalary();
  }catch(err){toast(friendly(err),'err')}
  setBtn('save-sal',false,'Salvar mês');
}
async function delSalary(id){
  const ok=await confirmModal('Excluir mês','Excluir este mês e todos os movimentos vinculados? Esta ação não pode ser desfeita.');
  if(!ok)return;
  ldr(true,'Excluindo...');
  try{
    await SB.del('salary_months',id);
    ST.months=ST.months.filter(s=>s.id!==id);
    ST.movs=ST.movs.filter(v=>v.salary_month_id!==id);
    toast('Mês excluído');renderSalary();
  }catch(err){toast(friendly(err),'err')}
  ldr(false);
}

/* ══════════════════════════════════════════════════════════════
   MODAIS — MOVIMENTO (adicionar / editar / duplicar)
══════════════════════════════════════════════════════════════ */
function movForm(data){
  data=data||{};
  const selRow=currentMonthRow();
  // valor padrão do select: mês selecionado (mesmo que ainda não exista no banco)
  const preSel=data.salary_month_id||(selRow?selRow.id:'__sel__');
  const selOpt='<option value="__sel__"'+(preSel==='__sel__'?' selected':'')+'>'+esc(ml(ST.sel.m,ST.sel.y))+(selRow?'':' (novo)')+'</option>';
  const mOpts=ST.months.map(s=>'<option value="'+esc(s.id)+'"'+(s.id===preSel?' selected':'')+'>'+esc(ml(s.month,s.year))+'</option>').join('');
  const cOpts=Object.entries(CATS).map(([k,v])=>'<option value="'+k+'"'+(k===data.category?' selected':'')+'>'+v.e+' '+v.l+'</option>').join('');
  const tOpts=Object.entries(TMAP).map(([k,l])=>{const em={entrada:'💚',saida:'🔴',investimento:'🔵',reserva:'🟡'}[k];
    return '<option value="'+k+'"'+(k===(data.type||'saida')?' selected':'')+'>'+em+' '+l+'</option>'}).join('');
  // se o mês selecionado ainda não existe no banco, oferecemos a opção __sel__ no topo
  const monthSelect=selRow?mOpts:(selOpt+mOpts);
  return '<div class="fg"><label class="lbl">Mês de referência</label>'+
      '<select class="inp" id="mv-sm">'+monthSelect+'</select></div>'+
    '<div class="fg"><label class="lbl">Descrição</label><input class="inp" type="text" id="mv-d" maxlength="120" value="'+esc(data.description||'')+'" placeholder="Ex: Conta de luz"/></div>'+
    '<div class="fr">'+
      '<div class="fg"><label class="lbl">Valor (R$)</label><input class="inp" type="number" id="mv-v" step="0.01" min="0" value="'+(data.amount!=null?esc(data.amount):'')+'" placeholder="0,00"/></div>'+
      '<div class="fg"><label class="lbl">Data</label><input class="inp" type="date" id="mv-dt" value="'+esc(data.date||new Date().toISOString().split('T')[0])+'"/></div></div>'+
    '<div class="fr">'+
      '<div class="fg"><label class="lbl">Tipo</label><select class="inp" id="mv-t">'+tOpts+'</select></div>'+
      '<div class="fg"><label class="lbl">Categoria</label><select class="inp" id="mv-c">'+cOpts+'</select></div></div>'+
    '<div style="display:flex;gap:8px;justify-content:flex-end;margin-top:8px">'+
      '<button class="btn btn-o" data-act="closeModal" type="button">Cancelar</button>'+
      '<button class="btn btn-g" id="save-mov" type="button" data-act="saveMov" data-arg="'+esc(data.id||'')+'">Salvar</button></div>';
}
function openAddMov(){openAddMovFor('')}
function openAddMovFor(sid){openModal('Adicionar movimento',movForm({salary_month_id:sid||null,type:'saida',category:'outros'}))}
function openEditMov(id){
  const v=ST.movs.find(x=>x.id===id);if(!v){toast('Movimento não encontrado','err');return}
  openModal('Editar movimento',movForm(v));
}
function dupMov(id){
  const v=ST.movs.find(x=>x.id===id);if(!v)return;
  openModal('Duplicar movimento',movForm({salary_month_id:v.salary_month_id,description:v.description,amount:v.amount,type:v.type,category:v.category,date:new Date().toISOString().split('T')[0]}));
}
async function saveMov(id){
  let sm=val('mv-sm')||null,desc=val('mv-d'),amount=num('mv-v'),date=val('mv-dt'),type=val('mv-t'),category=val('mv-c');
  fieldErr('mv-d','');fieldErr('mv-v','');
  let bad=false;
  if(!desc){fieldErr('mv-d','Informe a descrição.');bad=true}
  if(amount<=0){fieldErr('mv-v','Informe um valor maior que zero.');bad=true}
  if(bad)return;
  setBtn('save-mov',true);
  try{
    // "__sel__" ou vazio = mês selecionado ainda não gravado → cria e CONFIRMA
    if(sm==='__sel__'||!sm){
      const row=await ensureMonth();          // lança erro se não conseguir
      sm=row.id;
    }
    // trava de segurança: jamais gravar um movimento sem mês vinculado
    if(!sm)throw new Error('Movimento sem mês de referência. Recarregue e tente de novo.');

    const payload={salary_month_id:sm,description:desc,amount,date:date||null,type,category};
    if(id){
      const r=await SB.upd('movements',id,payload);
      if(!r||!r[0])throw new Error('A alteração não foi confirmada pelo servidor.');
      const i=ST.movs.findIndex(x=>x.id===id);if(i>=0)ST.movs[i]=r[0];
      /* atualização salva silenciosamente (sem notificação) */
    }else{
      const r=await SB.ins('movements',{...payload,user_id:uid()});
      // só considera salvo se o servidor devolveu a linha persistida
      if(!r||!r[0]||!r[0].id)throw new Error('O movimento não foi confirmado pelo servidor.');
      ST.movs.unshift(r[0]);
    }
    closeModal();
    if(ST.page==='movements')filterMov();
    else if(ST.page==='salary')renderSalary();
    else renderDash();
  }catch(err){
    // mostra o erro REAL para não mascarar falha de gravação
    toast('Não foi possível salvar: '+((err&&err.message)||'erro'),'err');
  }
  setBtn('save-mov',false,'Salvar');
}
async function delMov(id){
  const ok=await confirmModal('Excluir movimento','Deseja excluir este movimento?');
  if(!ok)return;
  ldr(true);
  try{await SB.del('movements',id);ST.movs=ST.movs.filter(v=>v.id!==id);toast('Excluído');
    ST.page==='movements'?filterMov():loadPage(ST.page);
  }catch(err){toast(friendly(err),'err')}
  ldr(false);
}

/* ══════════════════════════════════════════════════════════════
   MODAIS — INVESTIMENTO (adicionar / editar)
══════════════════════════════════════════════════════════════ */
function invForm(d){
  d=d||{};
  return '<div class="fg"><label class="lbl">Nome</label><input class="inp" type="text" id="ii-n" maxlength="80" value="'+esc(d.name||'')+'" placeholder="Ex: Tesouro Direto"/></div>'+
    '<div class="fg"><label class="lbl">Produto</label><input class="inp" type="text" id="ii-p" maxlength="120" value="'+esc(d.product||'')+'" placeholder="Ex: Tesouro Prefixado 2037"/></div>'+
    '<div class="fr">'+
      '<div class="fg"><label class="lbl">Valor aportado (R$)</label><input class="inp" type="number" id="ii-inv" step="0.01" min="0" value="'+(d.amount_invested!=null?esc(d.amount_invested):'')+'" placeholder="0,00"/></div>'+
      '<div class="fg"><label class="lbl">Valor atual (R$)</label><input class="inp" type="number" id="ii-cur" step="0.01" min="0" value="'+(d.current_value!=null?esc(d.current_value):'')+'" placeholder="0,00"/></div></div>'+
    '<div class="fr">'+
      '<div class="fg"><label class="lbl">Quantidade</label><input class="inp" type="number" id="ii-q" step="0.000001" min="0" value="'+(d.quantity!=null?esc(d.quantity):'')+'" placeholder="0"/></div>'+
      '<div class="fg"><label class="lbl">Valor unitário (R$)</label><input class="inp" type="number" id="ii-u" step="0.01" min="0" value="'+(d.unit_value!=null?esc(d.unit_value):'')+'" placeholder="0,00"/></div></div>'+
    '<div class="fr">'+
      '<div class="fg"><label class="lbl">Rentabilidade (% a.a.)</label><input class="inp" type="number" id="ii-r" step="0.01" value="'+(d.return_rate!=null?esc(d.return_rate):'')+'" placeholder="14,41"/></div>'+
      '<div class="fg"><label class="lbl">Data de compra</label><input class="inp" type="date" id="ii-d" value="'+esc(d.purchase_date||new Date().toISOString().split('T')[0])+'"/></div></div>'+
    '<div style="display:flex;gap:8px;justify-content:flex-end;margin-top:8px">'+
      '<button class="btn btn-o" data-act="closeModal" type="button">Cancelar</button>'+
      '<button class="btn btn-g" id="save-inv" data-act="saveInv" data-arg="'+esc(d.id||'')+'" type="button">Salvar</button></div>';
}
function openAddInv(){openModal('Novo investimento',invForm())}
function openEditInv(id){const i=ST.invs.find(x=>x.id===id);if(!i)return;openModal('Editar investimento',invForm(i))}
async function saveInv(id){
  const name=val('ii-n');fieldErr('ii-n','');
  if(!name){fieldErr('ii-n','Informe o nome.');return}
  const d={name,product:val('ii-p'),amount_invested:num('ii-inv'),current_value:num('ii-cur'),
    quantity:$('ii-q').value?num('ii-q'):null,unit_value:$('ii-u').value?num('ii-u'):null,
    return_rate:$('ii-r').value?num('ii-r'):null,purchase_date:val('ii-d')||null};
  setBtn('save-inv',true);
  try{
    if(id){const r=await SB.upd('investments',id,d);if(r?.[0]){const i=ST.invs.findIndex(x=>x.id===id);if(i>=0)ST.invs[i]=r[0]}/* salvo silenciosamente */}
    else{const r=await SB.ins('investments',{...d,user_id:uid()});if(r?.[0])ST.invs.unshift(r[0]);toast('Investimento adicionado!')}
    closeModal();renderInvPage();
  }catch(err){toast(friendly(err),'err')}
  setBtn('save-inv',false,'Salvar');
}
async function delInv(id){
  const ok=await confirmModal('Excluir investimento','Deseja excluir este investimento? O histórico de aportes também será removido.');if(!ok)return;
  ldr(true);
  try{
    await SB.del('investments',id);
    ST.invs=ST.invs.filter(i=>i.id!==id);
    ST.contribs=ST.contribs.filter(c=>c.investment_id!==id);   // aportes caem em cascata no banco
    toast('Excluído');renderInvPage();
  }catch(err){toast(friendly(err),'err')}
  ldr(false);
}

/* ══════════════════════════════════════════════════════════════
   APORTES — adiciona dinheiro a um investimento existente.
   NÃO cria novo investimento: registra o aporte no histórico e
   incrementa amount_invested (mantendo os cálculos atuais).
══════════════════════════════════════════════════════════════ */
function openAddContrib(invId){
  const inv=ST.invs.find(x=>x.id===invId);if(!inv){toast('Investimento não encontrado','err');return}
  openModal('Adicionar aporte — '+inv.name,
    '<p style="font-size:12.5px;color:var(--t2);margin-bottom:16px">Total aportado atual: <strong style="font-family:var(--m);color:var(--t1)">'+fmt(inv.amount_invested)+'</strong></p>'+
    '<div class="fr">'+
      '<div class="fg"><label class="lbl">Valor do aporte (R$)</label><input class="inp" type="number" id="ct-v" step="0.01" min="0" placeholder="0,00"/></div>'+
      '<div class="fg"><label class="lbl">Data do aporte</label><input class="inp" type="date" id="ct-d" value="'+new Date().toISOString().split('T')[0]+'"/></div></div>'+
    '<div class="fg"><label class="lbl">Observação (opcional)</label><input class="inp" type="text" id="ct-n" maxlength="120" placeholder="Ex: aporte mensal"/></div>'+
    '<div style="display:flex;gap:8px;justify-content:flex-end;margin-top:8px">'+
      '<button class="btn btn-o" data-act="closeModal" type="button">Cancelar</button>'+
      '<button class="btn btn-g" id="save-ct" data-act="saveContrib" data-arg="'+esc(invId)+'" type="button">Adicionar</button></div>');
}
async function saveContrib(invId){
  const inv=ST.invs.find(x=>x.id===invId);if(!inv)return;
  const amount=num('ct-v'),date=val('ct-d'),notes=val('ct-n');
  fieldErr('ct-v','');
  if(amount<=0){fieldErr('ct-v','Informe um valor maior que zero.');return}
  setBtn('save-ct',true);
  try{
    // 1) grava o aporte no histórico
    const cr=await SB.ins('investment_contributions',{investment_id:invId,amount,contribution_date:date||null,notes:notes||null,user_id:uid()});
    if(cr?.[0])ST.contribs.unshift(cr[0]);
    // 2) incrementa o total aportado — mesma coluna já usada nos cálculos
    const novoAportado=Number(inv.amount_invested)+amount;
    // valor atual acompanha o novo aporte (patrimônio sobe junto); rentabilidade
    // e lucro continuam sendo current_value - amount_invested, como antes.
    const novoAtual=Number(inv.current_value)+amount;
    const r=await SB.upd('investments',invId,{amount_invested:novoAportado,current_value:novoAtual});
    if(r?.[0]){const i=ST.invs.findIndex(x=>x.id===invId);if(i>=0)ST.invs[i]=r[0]}
    closeModal();renderInvPage();
  }catch(err){toast(friendly(err),'err')}
  setBtn('save-ct',false,'Adicionar');
}

/* ══════════════════════════════════════════════════════════════
   MODAIS — DÍVIDA
══════════════════════════════════════════════════════════════ */
function debtForm(d){
  d=d||{};
  return '<div class="fg"><label class="lbl">Descrição</label><input class="inp" type="text" id="dd-d" maxlength="120" value="'+esc(d.description||'')+'" placeholder="Ex: Conserto de celular"/></div>'+
    '<div class="fr">'+
      '<div class="fg"><label class="lbl">Valor total (R$)</label><input class="inp" type="number" id="dd-t" step="0.01" min="0" value="'+(d.total_amount!=null?esc(d.total_amount):'')+'" placeholder="600,00"/></div>'+
      '<div class="fg"><label class="lbl">Valor da parcela (R$)</label><input class="inp" type="number" id="dd-i" step="0.01" min="0" value="'+(d.installment_amount!=null?esc(d.installment_amount):'')+'" placeholder="100,00"/></div></div>'+
    '<div class="fr">'+
      '<div class="fg"><label class="lbl">Total de parcelas</label><input class="inp" type="number" id="dd-n" min="1" value="'+(d.installments_total!=null?esc(d.installments_total):'')+'" placeholder="6"/></div>'+
      '<div class="fg"><label class="lbl">Já pagas</label><input class="inp" type="number" id="dd-p" min="0" value="'+(d.installments_paid!=null?esc(d.installments_paid):'0')+'"/></div></div>'+
    '<div class="fr">'+
      '<div class="fg"><label class="lbl">Dia do vencimento</label><input class="inp" type="number" id="dd-day" min="1" max="31" value="'+(d.due_day!=null?esc(d.due_day):'')+'" placeholder="22"/></div>'+
      '<div class="fg"><label class="lbl">Data de início</label><input class="inp" type="date" id="dd-s" value="'+esc(d.start_date||new Date().toISOString().split('T')[0])+'"/></div></div>'+
    '<div style="display:flex;gap:8px;justify-content:flex-end;margin-top:8px">'+
      '<button class="btn btn-o" data-act="closeModal" type="button">Cancelar</button>'+
      '<button class="btn btn-g" id="save-debt" data-act="saveDebt" data-arg="'+esc(d.id||'')+'" type="button">Salvar dívida</button></div>';
}
function openAddDebt(){openModal('Nova dívida',debtForm())}
function openEditDebt(id){const d=ST.debts.find(x=>x.id===id);if(!d)return;openModal('Editar dívida',debtForm(d))}
async function saveDebt(id){
  const desc=val('dd-d');fieldErr('dd-d','');fieldErr('dd-p','');
  if(!desc){fieldErr('dd-d','Informe a descrição.');return}
  const nTot=intv('dd-n')||1,nPaid=intv('dd-p');
  if(nPaid>nTot){fieldErr('dd-p','Não pode ser maior que o total.');return}
  const d={description:desc,total_amount:num('dd-t'),installment_amount:num('dd-i'),
    installments_total:nTot,installments_paid:nPaid,due_day:$('dd-day').value?intv('dd-day'):null,start_date:val('dd-s')||null};
  setBtn('save-debt',true);
  try{
    if(id){const r=await SB.upd('debts',id,d);if(r?.[0]){const i=ST.debts.findIndex(x=>x.id===id);if(i>=0)ST.debts[i]=r[0]}/* salvo silenciosamente */}
    else{const r=await SB.ins('debts',{...d,user_id:uid()});if(r?.[0])ST.debts.unshift(r[0]);toast('Dívida registrada!')}
    closeModal();renderDebtPage();
  }catch(err){toast(friendly(err),'err')}
  setBtn('save-debt',false,'Salvar dívida');
}
async function payInst(dId){
  const d=ST.debts.find(x=>x.id===dId);if(!d)return;
  const num=Number(d.installments_paid)+1,amount=Number(d.installment_amount);
  const ok=await confirmModal('Registrar pagamento','Registrar a '+num+'ª parcela de '+fmt(amount)+'?');
  if(!ok)return;
  ldr(true,'Registrando...');
  try{
    await SB.ins('debt_payments',{debt_id:dId,amount,installment_number:num,payment_date:new Date().toISOString().split('T')[0],user_id:uid()});
    const r=await SB.upd('debts',dId,{installments_paid:num});
    if(r?.[0]){const i=ST.debts.findIndex(x=>x.id===dId);if(i>=0)ST.debts[i]=r[0]}
    toast(num+'ª parcela registrada! ✅');renderDebtPage();
  }catch(err){toast(friendly(err),'err')}
  ldr(false);
}
async function delDebt(id){
  const ok=await confirmModal('Excluir dívida','Deseja excluir esta dívida e seu histórico de pagamentos?');if(!ok)return;
  ldr(true);
  try{await SB.del('debts',id);ST.debts=ST.debts.filter(d=>d.id!==id);toast('Dívida excluída');renderDebtPage()}
  catch(err){toast(friendly(err),'err')}
  ldr(false);
}

/* ══════════════════════════════════════════════════════════════
   CONFIRMAÇÃO — modal reutilizável (substitui window.confirm)
══════════════════════════════════════════════════════════════ */
let confirmResolver=null;
function confirmModal(title,msg){
  return new Promise(resolve=>{
    confirmResolver=resolve;
    openModal(title,
      '<p style="font-size:14px;color:var(--t2);line-height:1.6;margin-bottom:20px">'+esc(msg)+'</p>'+
      '<div style="display:flex;gap:8px;justify-content:flex-end">'+
        '<button class="btn btn-o" data-confirm="0" type="button">Cancelar</button>'+
        '<button class="btn btn-r" data-confirm="1" type="button">Confirmar</button></div>');
  });
}
function resolveConfirm(v){if(confirmResolver){confirmResolver(v);confirmResolver=null}closeModal()}

/* ══════════════════════════════════════════════════════════════
   PERFIL — trocar nome, foto e senha
══════════════════════════════════════════════════════════════ */
function openProfile(){
  const url=avatarUrl(),name=displayName();
  openModal('Meu perfil',
    '<div class="av-edit" id="av-preview" style="'+(url?'background-image:url(\''+esc(url)+'\')':'')+'">'+(url?'':esc(name.charAt(0).toUpperCase()))+'</div>'+
    '<p style="text-align:center;font-size:11.5px;color:var(--t3);margin-bottom:18px">Clique na foto para alterar</p>'+
    '<div class="fg"><label class="lbl">Nome</label><input class="inp" type="text" id="pf-name" maxlength="80" value="'+esc(name)+'"/></div>'+
    '<div class="fg"><label class="lbl">E-mail</label><input class="inp" type="email" value="'+esc(SES?.user?.email||'')+'" disabled style="opacity:.6"/></div>'+
    '<div style="display:flex;gap:8px;justify-content:flex-end;margin-top:4px">'+
      '<button class="btn btn-o" data-act="closeModal" type="button">Fechar</button>'+
      '<button class="btn btn-g" id="save-pf" data-act="saveProfile" type="button">Salvar alterações</button></div>'+
    '<div class="dv"></div>'+
    '<div class="fg"><label class="lbl">Alterar senha</label>'+
      '<input class="inp" type="password" id="pf-pass" autocomplete="new-password" placeholder="Nova senha (mín. 6 caracteres)"/></div>'+
    '<div style="display:flex;justify-content:flex-end">'+
      '<button class="btn btn-o" id="save-pass" data-act="changePassword" type="button">Atualizar senha</button></div>');
  $('av-preview').addEventListener('click',()=>$('av-file').click());
}
async function saveProfile(){
  const name=val('pf-name');fieldErr('pf-name','');
  if(!name){fieldErr('pf-name','Informe seu nome.');return}
  setBtn('save-pf',true);
  try{
    await SB.updateUser({data:{name}});                         // metadata do Auth
    const r=await SB.upsertProfile({id:uid(),full_name:name});  // tabela profiles
    ST.profile=r?.[0]||{...ST.profile,full_name:name};
    if(SES.user){SES.user.user_metadata={...(SES.user.user_metadata||{}),name};saveSes()}
    paintProfile();toast('Perfil atualizado!');closeModal();
  }catch(err){toast(friendly(err),'err')}
  setBtn('save-pf',false,'Salvar alterações');
}
async function changePassword(){
  const pass=val('pf-pass');
  if(pass.length<6){toast('A senha deve ter pelo menos 6 caracteres.','err');return}
  setBtn('save-pass',true);
  try{await SB.updateUser({password:pass});toast('Senha atualizada com sucesso!');$('pf-pass').value=''}
  catch(err){toast(friendly(err),'err')}
  setBtn('save-pass',false,'Atualizar senha');
}
async function onAvatarPicked(ev){
  const file=ev.target.files?.[0];ev.target.value='';
  if(!file)return;
  if(file.size>3*1024*1024){toast('A imagem deve ter no máximo 3 MB.','err');return}
  ldr(true,'Enviando foto...');
  try{
    const url=await SB.uploadAvatar(uid(),file);
    await SB.updateUser({data:{avatar_url:url}});
    const r=await SB.upsertProfile({id:uid(),avatar_url:url});
    ST.profile=r?.[0]||{...ST.profile,avatar_url:url};
    if(SES.user){SES.user.user_metadata={...(SES.user.user_metadata||{}),avatar_url:url};saveSes()}
    paintProfile();
    const pv=$('av-preview');if(pv){pv.style.backgroundImage='url("'+url+'")';pv.textContent=''}
    toast('Foto atualizada!');
  }catch(err){toast('Não foi possível enviar a foto. Verifique se o bucket "avatars" existe.','err')}
  ldr(false);
}

/* ══════════════════════════════════════════════════════════════
   DELEGAÇÃO DE EVENTOS — um único listener (sem listeners
   duplicados, sem onclick inline, sem vazamento de memória).
   As ações são despachadas por data-attributes.
══════════════════════════════════════════════════════════════ */
const ACTIONS={openAddSalary,saveSalary,delSalary,openAddMov,openAddMovFor,openEditMov,dupMov,saveMov,delMov,
  openAddInv,openEditInv,saveInv,delInv,openAddContrib,saveContrib,openAddDebt,openEditDebt,saveDebt,payInst,delDebt,
  openProfile,saveProfile,changePassword,closeModal};

document.addEventListener('click',e=>{
  const navEl=e.target.closest('[data-nav]');
  if(navEl){nav(navEl.dataset.nav);return}
  const actEl=e.target.closest('[data-act]');
  if(actEl){const fn=ACTIONS[actEl.dataset.act];if(fn)fn(actEl.dataset.arg);return}
  const cEl=e.target.closest('[data-confirm]');
  if(cEl){resolveConfirm(cEl.dataset.confirm==='1');return}
  const pEl=e.target.closest('[data-page]');
  if(pEl){if(pEl.dataset.page==='prev')ST.mov.page--;else ST.mov.page++;filterMov();return}
  const tabEl=e.target.closest('[data-tab]');
  if(tabEl){authTab(tabEl.dataset.tab);return}
  const goEl=e.target.closest('[data-goto]');
  if(goEl){showForm(goEl.dataset.goto);return}
});
// teclado na navegação (acessibilidade)
document.addEventListener('keydown',e=>{
  if(e.key==='Escape'&&$('mbg').classList.contains('open')){if(confirmResolver)resolveConfirm(false);else closeModal()}
  if((e.key==='Enter'||e.key===' ')&&e.target.classList?.contains('sb-item')){e.preventDefault();nav(e.target.dataset.nav)}
});

// listeners fixos (registrados uma única vez)
$('af-login').addEventListener('submit',doLogin);
$('af-register').addEventListener('submit',doRegister);
$('af-recover').addEventListener('submit',doRecover);
$('sb-logout').addEventListener('click',doLogout);
$('sb-av').addEventListener('click',openProfile);
$('sb-profile-open').addEventListener('click',openProfile);
$('m-close').addEventListener('click',()=>{if(confirmResolver)resolveConfirm(false);else closeModal()});
$('mbg').addEventListener('click',e=>{if(e.target.id==='mbg'){if(confirmResolver)resolveConfirm(false);else closeModal()}});
$('av-file').addEventListener('change',onAvatarPicked);

// navegação por mês (barra fixa no topo)
$('mnav-prev').addEventListener('click',()=>changeMonth(-1));
$('mnav-next').addEventListener('click',()=>changeMonth(1));
$('mnav-label').addEventListener('click',goCurrentMonth);

// filtros de movimentos (com debounce na busca)
let searchTimer=null;
$('mf-q').addEventListener('input',()=>{clearTimeout(searchTimer);searchTimer=setTimeout(()=>{ST.mov.page=1;filterMov()},250)});
['mf-m','mf-t','mf-c','mf-sort'].forEach(id=>$(id).addEventListener('change',()=>{ST.mov.page=1;filterMov()}));

// validação em tempo real no cadastro
$('r-email').addEventListener('input',()=>{
  const v=$('r-email').value.trim(),h=$('r-email-hint');
  if(!v){h.textContent='';h.className='inp-hint';return}
  const ok=isEmail(v);h.textContent=ok?'E-mail válido':'E-mail inválido';h.className='inp-hint '+(ok?'ok':'err');
});
$('r-pass').addEventListener('input',()=>{
  const v=$('r-pass').value,h=$('r-pass-hint');
  if(!v){h.textContent='';h.className='inp-hint';return}
  const ok=v.length>=6;h.textContent=ok?'Senha ok':'Mínimo 6 caracteres';h.className='inp-hint '+(ok?'ok':'err');
});

/* ══════════════════════════════════════════════════════════════
   INICIALIZAÇÃO
   Fluxo: sessão válida → app · sem sessão → login
   Suporta o retorno do link de recuperação (#type=recovery).
══════════════════════════════════════════════════════════════ */
function initChartsDefaults(){
  if(window.Chart){Chart.defaults.color='#64748b';Chart.defaults.font.family='Inter,system-ui,sans-serif'}
}
function parseHashTokens(){
  if(!location.hash)return null;
  const p=new URLSearchParams(location.hash.slice(1));
  if(p.get('access_token'))return{
    access_token:p.get('access_token'),refresh_token:p.get('refresh_token'),
    expires_in:Number(p.get('expires_in')||3600),type:p.get('type')};
  return null;
}
async function handleRecoveryRedirect(t){
  setSessionFromAuth({access_token:t.access_token,refresh_token:t.refresh_token,expires_in:t.expires_in,user:null});
  history.replaceState(null,'',location.pathname+location.search);
  try{const rows=await SB.get('profiles','id=eq.'+(SES?.user?.id||''));}catch{}
  // busca dados do usuário atual
  try{const u=await SB.call('/auth/v1/user');if(u){SES.user=u;saveSes()}}catch{}
  showSc('auth');showForm('login');
  openModal('Criar nova senha',
    '<p style="font-size:13.5px;color:var(--t2);margin-bottom:16px">Defina sua nova senha de acesso.</p>'+
    '<div class="fg"><label class="lbl">Nova senha</label><input class="inp" type="password" id="rec-newpass" autocomplete="new-password" placeholder="Mínimo 6 caracteres"/></div>'+
    '<div style="display:flex;justify-content:flex-end"><button class="btn btn-g" id="rec-save" type="button">Salvar nova senha</button></div>');
  $('rec-save').addEventListener('click',async()=>{
    const p=val('rec-newpass');if(p.length<6){toast('Mínimo 6 caracteres.','err');return}
    setBtn('rec-save',true);
    try{await SB.updateUser({password:p});toast('Senha alterada! Entrando...');closeModal();await enterApp()}
    catch(err){toast(friendly(err),'err')}
    setBtn('rec-save',false,'Salvar nova senha');
  });
}

async function init(){
  initChartsDefaults();
  const t=parseHashTokens();
  if(t&&t.type==='recovery'){await handleRecoveryRedirect(t);return}
  if(SES?.access_token){
    if(SES.expires_at&&Date.now()>SES.expires_at-30000){
      ldr(true,'Restaurando sessão...');
      const ok=await refreshToken();
      ldr(false);
      if(!ok){clearSes();showSc('auth');return}
    }else scheduleRefresh();
    // valida o usuário; se o token estiver inválido, cai para o login
    try{await enterApp()}catch{clearSes();showSc('auth')}
  }else{
    showSc('auth');
  }
}
// Chart.js é carregado com defer; garantimos que exista antes de iniciar
if(document.readyState==='loading')document.addEventListener('DOMContentLoaded',init);
else init();
</script>
</body>
</html>
