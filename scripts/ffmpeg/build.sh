#!/usr/bin/env bash

case $ANDROID_ABI in
  x86)
    # Disabling assembler optimizations, because they have text relocations
    EXTRA_BUILD_CONFIGURATION_FLAGS="$EXTRA_BUILD_CONFIGURATION_FLAGS --disable-asm"
    ;;
  x86_64)
    EXTRA_BUILD_CONFIGURATION_FLAGS="$EXTRA_BUILD_CONFIGURATION_FLAGS --x86asmexe=${FAM_YASM}"
    ;;
esac

if [ "$FFMPEG_GPL_ENABLED" = true ] ; then
    EXTRA_BUILD_CONFIGURATION_FLAGS="$EXTRA_BUILD_CONFIGURATION_FLAGS --enable-gpl"
fi

# Preparing flags for enabling requested libraries
ADDITIONAL_COMPONENTS=
for LIBARY_NAME in ${FFMPEG_EXTERNAL_LIBRARIES[@]}
do
  ADDITIONAL_COMPONENTS+=" --enable-$LIBARY_NAME"
done

# Referencing dependencies without pkgconfig
DEP_CFLAGS="-I${BUILD_DIR_EXTERNAL}/${ANDROID_ABI}/include"
DEP_LD_FLAGS="-L${BUILD_DIR_EXTERNAL}/${ANDROID_ABI}/lib $FFMPEG_EXTRA_LD_FLAGS"

# Android 15 with 16 kb page size support
# https://developer.android.com/guide/practices/page-sizes#compile-r27
EXTRA_LDFLAGS="-Wl,-z,max-page-size=16384 $DEP_LD_FLAGS"

./configure \
  --prefix=${BUILD_DIR_FFMPEG}/${ANDROID_ABI} \
  --enable-cross-compile \
  --target-os=android \
  --arch=${TARGET_TRIPLE_MACHINE_ARCH} \
  --sysroot=${SYSROOT_PATH} \
  --cc=${FAM_CC} \
  --cxx=${FAM_CXX} \
  --ld=${FAM_LD} \
  --ar=${FAM_AR} \
  --as=${FAM_CC} \
  --nm=${FAM_NM} \
  --ranlib=${FAM_RANLIB} \
  --strip=${FAM_STRIP} \
  --extra-cflags="-O3 -fPIC $DEP_CFLAGS" \
  --extra-ldflags="$EXTRA_LDFLAGS" \
  --enable-shared \
  --disable-static \
  --disable-vulkan \
  --pkg-config=${PKG_CONFIG_EXECUTABLE} \
  ${EXTRA_BUILD_CONFIGURATION_FLAGS} \
  --disable-protocols \
  --disable-muxers \
  --disable-encoders \
  --disable-avdevice \
  --disable-postproc \
  --disable-doc \
  --disable-zlib \
  --disable-debug \
  --disable-network \
  --disable-programs \
  --disable-swscale \
  --disable-bsfs \
  --disable-filters \
  --disable-decoder=012v \
  --disable-decoder=4xm \
  --disable-decoder=8bps \
  --disable-decoder=aasc \
  --disable-decoder=agm \
  --disable-decoder=aic \
  --disable-decoder=alias_pix \
  --disable-decoder=amv \
  --disable-decoder=anm \
  --disable-decoder=ansi \
  --disable-decoder=apng \
  --disable-decoder=arbc \
  --disable-decoder=asv1 \
  --disable-decoder=asv2 \
  --disable-decoder=aura \
  --disable-decoder=aura2 \
  --disable-decoder=libdav1d \
  --disable-decoder=libaom-av1 \
  --disable-decoder=avrn \
  --disable-decoder=avrp \
  --disable-decoder=avs \
  --disable-decoder=avui \
  --disable-decoder=ayuv \
  --disable-decoder=bethsoftvid \
  --disable-decoder=bfi \
  --disable-decoder=binkvideo \
  --disable-decoder=bintext \
  --disable-decoder=bitpacked \
  --disable-decoder=bmp \
  --disable-decoder=bmv_video \
  --disable-decoder=brender_pix \
  --disable-decoder=c93 \
  --disable-decoder=cavs \
  --disable-decoder=cdgraphics \
  --disable-decoder=cdtoons \
  --disable-decoder=cdxl \
  --disable-decoder=cfhd \
  --disable-decoder=cinepak \
  --disable-decoder=clearvideo \
  --disable-decoder=cljr \
  --disable-decoder=cllc \
  --disable-decoder=eacmv \
  --disable-decoder=cpia \
  --disable-decoder=camstudio \
  --disable-decoder=cyuv \
  --disable-decoder=dds \
  --disable-decoder=dfa \
  --disable-decoder=dirac \
  --disable-decoder=dnxhd \
  --disable-decoder=dpx \
  --disable-decoder=dsicinvideo \
  --disable-decoder=dvvideo \
  --disable-decoder=dxa \
  --disable-decoder=dxtory \
  --disable-decoder=dxv \
  --disable-decoder=escape124 \
  --disable-decoder=escape130 \
  --disable-decoder=exr \
  --disable-decoder=ffv1 \
  --disable-decoder=ffvhuff \
  --disable-decoder=fic \
  --disable-decoder=fits \
  --disable-decoder=flashsv \
  --disable-decoder=flashsv2 \
  --disable-decoder=flic \
  --disable-decoder=flv \
  --disable-decoder=fmvc \
  --disable-decoder=fraps \
  --disable-decoder=frwu \
  --disable-decoder=g2m \
  --disable-decoder=gdv \
  --disable-decoder=gif \
  --disable-decoder=h261 \
  --disable-decoder=h263 \
  --disable-decoder=h263i \
  --disable-decoder=h263p \
  --disable-decoder=h264 \
  --disable-decoder=hap \
  --disable-decoder=hevc \
  --disable-decoder=hnm4video \
  --disable-decoder=hq_hqa \
  --disable-decoder=hqx \
  --disable-decoder=huffyuv \
  --disable-decoder=hymt \
  --disable-decoder=idcinvideo \
  --disable-decoder=idf \
  --disable-decoder=iff \
  --disable-decoder=imm4 \
  --disable-decoder=imm5 \
  --disable-decoder=indeo2 \
  --disable-decoder=indeo3 \
  --disable-decoder=indeo4 \
  --disable-decoder=indeo5 \
  --disable-decoder=interplayvideo \
  --disable-decoder=jpeg2000 \
  --disable-decoder=libopenjpeg \
  --disable-decoder=jpegls \
  --disable-decoder=jv \
  --disable-decoder=kgv1 \
  --disable-decoder=kmvc \
  --disable-decoder=lagarith \
  --disable-decoder=loco \
  --disable-decoder=lscr \
  --disable-decoder=m101 \
  --disable-decoder=eamad \
  --disable-decoder=magicyuv \
  --disable-decoder=mdec \
  --disable-decoder=mimic \
  --disable-decoder=mjpeg \
  --disable-decoder=mjpegb \
  --disable-decoder=mmvideo \
  --disable-decoder=motionpixels \
  --disable-decoder=mpeg1video \
  --disable-decoder=mpeg2video \
  --disable-decoder=mpegvideo \
  --disable-decoder=mpeg4 \
  --disable-decoder=msa1 \
  --disable-decoder=mscc \
  --disable-decoder=msmpeg4v1 \
  --disable-decoder=msmpeg4v2 \
  --disable-decoder=msmpeg4 \
  --disable-decoder=msrle \
  --disable-decoder=mss1 \
  --disable-decoder=mss2 \
  --disable-decoder=msvideo1 \
  --disable-decoder=mszh \
  --disable-decoder=mts2 \
  --disable-decoder=mv30 \
  --disable-decoder=mvc1 \
  --disable-decoder=mvc2 \
  --disable-decoder=mvdv \
  --disable-decoder=mvha \
  --disable-decoder=mwsc \
  --disable-decoder=mxpeg \
  --disable-decoder=notchlc \
  --disable-decoder=nuv \
  --disable-decoder=paf_video \
  --disable-decoder=pam \
  --disable-decoder=pbm \
  --disable-decoder=pcx \
  --disable-decoder=pfm \
  --disable-decoder=pgm \
  --disable-decoder=pgmyuv \
  --disable-decoder=pictor \
  --disable-decoder=pixlet \
  --disable-decoder=png \
  --disable-decoder=ppm \
  --disable-decoder=prores \
  --disable-decoder=prosumer \
  --disable-decoder=psd \
  --disable-decoder=ptx \
  --disable-decoder=qdraw \
  --disable-decoder=qpeg \
  --disable-decoder=qtrle \
  --disable-decoder=r10k \
  --disable-decoder=r210 \
  --disable-decoder=rasc \
  --disable-decoder=rawvideo \
  --disable-decoder=rl2 \
  --disable-decoder=roqvideo \
  --disable-decoder=rpza \
  --disable-decoder=rscc \
  --disable-decoder=rv10 \
  --disable-decoder=rv20 \
  --disable-decoder=rv30 \
  --disable-decoder=rv40 \
  --disable-decoder=sanm \
  --disable-decoder=scpr \
  --disable-decoder=screenpresso \
  --disable-decoder=sgi \
  --disable-decoder=sgirle \
  --disable-decoder=sheervideo \
  --disable-decoder=smackvid \
  --disable-decoder=smc \
  --disable-decoder=smvjpeg \
  --disable-decoder=snow \
  --disable-decoder=sp5x \
  --disable-decoder=speedhq \
  --disable-decoder=srgc \
  --disable-decoder=sunrast \
  --disable-decoder=svq1 \
  --disable-decoder=svq3 \
  --disable-decoder=targa \
  --disable-decoder=targa_y216 \
  --disable-decoder=tdsc \
  --disable-decoder=eatgq \
  --disable-decoder=eatgv \
  --disable-decoder=theora \
  --disable-decoder=thp \
  --disable-decoder=tiertexseqvideo \
  --disable-decoder=tiff \
  --disable-decoder=tmv \
  --disable-decoder=eatqi \
  --disable-decoder=truemotion1 \
  --disable-decoder=truemotion2 \
  --disable-decoder=truemotion2rt \
  --disable-decoder=camtasia \
  --disable-decoder=tscc2 \
  --disable-decoder=txd \
  --disable-decoder=ultimotion \
  --disable-decoder=utvideo \
  --disable-decoder=v210 \
  --disable-decoder=v210x \
  --disable-decoder=v308 \
  --disable-decoder=v408 \
  --disable-decoder=v410 \
  --disable-decoder=vb \
  --disable-decoder=vble \
  --disable-decoder=vc1 \
  --disable-decoder=vc1image \
  --disable-decoder=vcr1 \
  --disable-decoder=xl \
  --disable-decoder=vmdvideo \
  --disable-decoder=vmnc \
  --disable-decoder=vp3 \
  --disable-decoder=vp4 \
  --disable-decoder=vp5 \
  --disable-decoder=vp6 \
  --disable-decoder=vp6a \
  --disable-decoder=vp6f \
  --disable-decoder=vp7 \
  --disable-decoder=vp8 \
  --disable-decoder=libvpx \
  --disable-decoder=vp9 \
  --disable-decoder=libvpx-vp9 \
  --disable-decoder=wcmv \
  --disable-decoder=webp \
  --disable-decoder=wmv1 \
  --disable-decoder=wmv2 \
  --disable-decoder=wmv3 \
  --disable-decoder=wmv3image \
  --disable-decoder=wnv1 \
  --disable-decoder=wrapped_avframe \
  --disable-decoder=vqavideo \
  --disable-decoder=xan_wc3 \
  --disable-decoder=xan_wc4 \
  --disable-decoder=xbin \
  --disable-decoder=xbm \
  --disable-decoder=xface \
  --disable-decoder=xpm \
  --disable-decoder=xwd \
  --disable-decoder=y41p \
  --disable-decoder=ylc \
  --disable-decoder=yop \
  --disable-decoder=yuv4 \
  --disable-decoder=zerocodec \
  --disable-decoder=zlib \
  --disable-decoder=zmbv \
  --disable-decoder=ssa \
  --disable-decoder=ass \
  --disable-decoder=dvbsub \
  --disable-decoder=dvdsub \
  --disable-decoder=cc_dec \
  --disable-decoder=pgssub \
  --disable-decoder=jacosub \
  --disable-decoder=microdvd \
  --disable-decoder=mov_text \
  --disable-decoder=mpl2 \
  --disable-decoder=pjs \
  --disable-decoder=realtext \
  --disable-decoder=sami \
  --disable-decoder=stl \
  --disable-decoder=srt \
  --disable-decoder=subrip \
  --disable-decoder=subviewer \
  --disable-decoder=subviewer1 \
  --disable-decoder=text \
  --disable-decoder=vplayer \
  --disable-decoder=webvtt \
  --disable-decoder=xsub \
  --enable-small \
  --enable-protocol=file \
  $ADDITIONAL_COMPONENTS || exit 1

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j16
${MAKE_EXECUTABLE} install
