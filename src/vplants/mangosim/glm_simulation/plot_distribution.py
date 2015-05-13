
def plot_histo(keys, allvalues, _title = None, reference = None):
    import matplotlib.pyplot as plt
    import numpy as np
    fig, ax = plt.subplots()
    nbplot = len(allvalues)
    nbx = len(allvalues[0])
    width = 1
    if nbplot <= 5:
        #colors = plt.get_cmap('jet',nbplot)
        colors = lambda x: ['r','y','g','b','c','m'][x]
        ind = np.arange(0,nbx*(nbplot+1)*width,(nbplot+1)*width)
        for i,values in enumerate(allvalues):
            ax.bar(ind+(i+0.5)*width, values, width,color=colors(i) )
        ax.set_xticks(ind+(nbplot+1)*width/2.)
    else:
        ind = np.arange(0,nbx*width,width)+width
        print ind
        if reference : ax.bar(ind-width/4., reference, width/2., color='r' )
        bpdata = [[v[i] for v in allvalues] for i in range(nbx)]
        ax.boxplot(bpdata, widths=1)
        ax.set_xticks(ind)

    ax.set_xticklabels(keys, rotation=90)
    if _title: ax.set_title(_title)
    #fig.set_size_inches(1600,800)
    plt.show()


def plot_histo_curve(keys, allvalues, _title = None, legends = None):
    import matplotlib.pyplot as plt
    import numpy as np
    #fig, ax = plt.subplots()
    fig = plt.figure(figsize=(20,10))
    ax = fig.add_subplot(111)
    print 'ax', ax
    nbplot = len(allvalues)
    nbx = len(allvalues[0])
    width = 1
    if nbplot > 6:
        _colors = plt.get_cmap('jet',nbplot)
        colors = lambda x: _colors(nbplot-1-x)
    else:
        colors = lambda x: ['r','y','g','b','c','m'][x]
    ind = np.arange(0,nbx*width,width)
    for i,values in enumerate(allvalues):
        ax.plot(ind, values, '-o', color=colors(i), label = '' if legends is None else legends[i] )
    ax.set_xticks(ind)

    ax.set_xticklabels(keys, rotation=90)
    if _title: ax.set_title(_title)
    if legends : ax.legend(loc=2)
    plt.show()