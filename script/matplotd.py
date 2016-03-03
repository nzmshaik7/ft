#!/usr/bin/env python


HOST = "localhost"
PORT = 7001
RECVSIZE = 10000

import SocketServer
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import locale
import sys
import os



# Return the operation and filename.
#
def opAndFile(lines):
    toks = lines[0].split(',')
    if len(toks) < 2:
        return(toks[0], None)
    else:
        return(toks[0], toks[1])


def clubfees(req, lines, fname, isLoss):
    # The slices will be ordered and plotted counter-clockwise.
    if not fname:
        req.sendall("Missing clubfees filename\n")
        return
    if len(lines) < 2:
        req.sendall("Empty clubfees data\n")
        return
    valtoks = lines[1].split(',')
    if len(valtoks) < 3:
        req.sendall("Missing clubfees data\n")
        return
    
    schedf = float(valtoks[0])
    unschedf = float(valtoks[1])
    deltaf = float(valtoks[2])
    totalf = schedf + unschedf + deltaf
    sizes = [ schedf, unschedf, deltaf ]

    scheddol = locale.currency(schedf, grouping=True)
    unscheddol = locale.currency(unschedf, grouping=True)
    deltadol = locale.currency(deltaf, grouping=True)

    if isLoss:
        colors = [ '#c040ff', 'lightskyblue', '#ff4040' ]
        labels = [ "Unscheduled\n%s\n%1.1f%%" % 
                                       (unscheddol, 100.0 * unschedf / totalf), 
                   "Scheduled\n%s\n%1.1f%%" % 
                                       (scheddol, 100.0 * schedf / totalf), 
                   "Gross Loss\n%s\n%1.1f%%" % 
                                       (deltadol, 100.0 * deltaf / totalf) ]
    else:
        colors = [ '#c040ff', 'lightskyblue', 'green' ]
        labels = [ "Unscheduled\n%1.1f%%" % (100.0 * unschedf / totalf), 
                   "Scheduled\n%1.1f%%" % (100.0 * schedf / totalf), 
                   "Gross Profit\n%1.1f%%" % (100.0 * deltaf / totalf) ]
    # explode = (0, 0.1, 0, 0)  # only "explode" the 2nd slice (i.e. 'Hogs')
    fig = plt.figure(figsize=(4,4))

    plt.pie(sizes, labels=labels, colors=colors, labeldistance=0.35, 
                   shadow=True)
    # Set aspect ratio to be equal so that pie is drawn as a circle.
    plt.axis('equal')
    fig.savefig(fname, dpi=72)
    req.sendall("OK\n")


class MyTCPHandler(SocketServer.BaseRequestHandler):

    def handle(self):
        allData = ''
        while True:
            data = self.request.recv(RECVSIZE)
            if not data:
                #D print "No more data"
                break
            allData += data
            #D print "Got", len(data), "bytes"
        lines = allData.split('\n')
        for ln in lines:
            print ln
        sys.stdout.flush()
        (op, fname) = opAndFile(lines)
        if op == 'clubfeesloss':
            clubfees(self.request, lines, fname, True)
        elif op == 'clubfeesloss':
            clubfees(self.request, lines, fname, False)
        else:
            self.request.sendall("Unknown operator: %s\n" % (op))


if __name__ == "__main__":

    locale.setlocale(locale.LC_ALL, '')

    # Create the server, binding to localhost 
    server = SocketServer.TCPServer((HOST, PORT), MyTCPHandler)

    # Activate the server; this will keep running until you
    # interrupt the program with Ctrl-C
    server.serve_forever()
