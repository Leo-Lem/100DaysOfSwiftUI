//
//  Country.swift
//  Flags
//
//  Created by Leopold Lemmermann on 15.02.22.
//

import Foundation

enum Country: String, CaseIterable, Equatable, Codable {
    case af, al, dz, `as`, ad, ao, ai, aq, ag, ar, am, aw, au, at, az, bs, bh, bd, bb, by, be, bz, bj, bm, bt, bo, ba, bw, bv, br, bn, bg, bf, bi, kh, cm, ca, cv, ky, cf, td, cl, cn, cx, co, km, cg, cd, ck, cr, ci, hr, cu, cy, cz, dk, dj, dm, `do`, ec, eg, sv, gq, er, ee, et, fk, fo, fj, fi, fr, gf, pf, ga, gm, ge, de, gh, gi, gr, gl, gd, gp, gu, gt, gg, gn, gw, gy, ht, va, hn, hk, hu, `is`, `in`, `id`, ir, iq, ie, im, il, it, jm, jp, je, jo, kz, ke, ki, kp, kr, kw, kg, lv, lb, ls, lr, ly, li, lt, lu, mo, mk, mg, mw, my, mv, ml, mt, mh, mq, mr, mu, yt, mx, fm, md, mc, mn, ms, ma, mz, mm, na, nr, np, nl, nc, nz, ni, ne, ng, nu, nf, mp, no, om, pk, pw, pa, pg, py, pe, ph, pn, pl, pt, pr, qa, re, ro, ru, rw, sh, kn, lc, pm, vc, ws, sm, st, sa, sn, sc, sl, sg, sk, si, sb, so, za, es, lk, sd, sr, sz, se, ch, sy, tw, tj, tz, th, tl, tg, tk, to, tt, tn, tr, tm, tc, tv, ug, ua, ae, gb, us, uy, uz, vu, ve, vn, wf, eh, ye, zm, zw
    
    static func random(_ n: Int) -> [Country] { Array(allCases.shuffled().prefix(n)) }
}
