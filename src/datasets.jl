

function descriptiondict(description)
    fields = split(description, r"[ =]")[2:end]
    dict = Dict{String, String}()

    for i = 1:2:length(fields)
        dict[fields[i]] = fields[i+1]
    end

    dict
end

function load_seq_motif(file="hk1_reg_region.fa", motiffile="hk1_motifs.bed"; projectdir=getprojectdir())
    filepath = joinpath(projectdir, "data", file)
    motifpath = joinpath(projectdir, "data", "hk1_motifs.bed")

    reader = FASTAReader(open(filepath))
    record = first(reader)
    close(reader)

    record

    seq = sequence(record)
    desc = description(record)
    dd = descriptiondict(desc)
    chromloc = split(dd["range"], r"[:-]")
    chrom  = first(chromloc)
    loc = parse(Int, chromloc[2]):parse(Int, chromloc[3])


    # take care this is not a proper bed file, its 1-based inclusive coordinates
    motifs = CSV.read(motifpath, DataFrame, header=[:chrom, :start, :stop, :name, :seq])
    motifs.valid = falses(size(motifs, 1))
    motifs.rstart = motifs.start .- first(loc) .+ 1
    motifs.rstop  = motifs.stop .- first(loc) .+ 1
    @assert [seq[s:e] for (s, e) in zip(motifs.rstart, motifs.rstop)] == motifs.seq
    

    
    (; chrom, loc, seq, motifs)

end


function simulate(region, config, numreads; pr_accessible=0.95, pr_inaccessible=0.05)

end